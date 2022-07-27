import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../appBrain.dart';
import '../widgets/textFieldWidgets.dart';


class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ImagePicker image = ImagePicker();
  String? url;
  String? selectedDivision;
  int userScore = 0;
  int random = Random().nextInt(100000);
  File? file;
  final _formkey = new GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<String> _divisionList = [
    'NRSOD',
    'SRSOD',
    'YSOD',
    'JSOD',
    'WR911 '
  ];
  var _date = DateTime.now();

  selectImage() async {
    try {
      var img = await image.pickImage(source: ImageSource.gallery);
      setState(() {
        file = File(img!.path);
      });
    } catch (e) {
      showSnakBar(context, '$e', Duration(milliseconds: 4000));
    }
  }

// =====================================================================
// Register new user
//
  addNewUser() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    var profileImage =
        await FirebaseStorage.instance.ref().child('images/$random');
    UploadTask task = profileImage.putFile(file!);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((value) {
      FirebaseFirestore.instance
          .collection('userData')
          .doc(value.user!.uid)
          .set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'fullname': _nameController.text.trim(),
        'age': _date,
        'email': _emailController.text.trim(),
        'imageUrl': url,
        'division': selectedDivision,
        'userScore': userScore,
        'created at': Timestamp.now(),
      });
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              Text('Create A New Account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(fontSize: 45)),
              GestureDetector(
                onTap: (() => selectImage()),
                child: Container(
                  height: 150,
                  width: 150,
                  child: file != null
                      ? CircleAvatar(backgroundImage: FileImage(file!))
                      : CircleAvatar(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                              ),
                              Text('Add Your Picture')
                            ],
                          ),
                          radius: 80,
                        ),
                ),
              ),
              // Text Fields
              SizedBox(height: 20),
              buildNameTextFormField(_nameController),
              SizedBox(height: 20),
              buildEmailTextFormField(_emailController),
              SizedBox(height: 20),
              buildPasswordTextFormField(_passwordController),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
                child: DropdownButtonFormField(
                  value: selectedDivision,
                  validator: ((value) {
                    if (value == null) {
                      return 'Please Select your division';
                    } else {
                      return null;
                    }
                  }),
                  items: _divisionList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDivision = value as String;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.deepPurple,
                  ),
                  decoration: InputDecoration(
                      hintText: "Division",
                      icon: Icon(Icons.location_city),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text('${_date.day}/${_date.month}/${_date.year}'),
                    subtitle: Text('Date of Birth'),
                    trailing: IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2100));
                        if (newDate == null) return;
                        setState(() {
                          _date = newDate;
                        });
                      },
                    ),
                  )),
              MaterialButton(
                onPressed: () {
                  try {
                    final isValid = _formkey.currentState!.validate();
                    if (isValid) {
                      _formkey.currentState!.save();
                      addNewUser();
                    }
                    return null;
                  } on FirebaseAuthException catch (e) {}
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: widget.showLoginPage,
                child: Text(
                  "Already a member? Sign In Now",
                  style: TextStyle(fontSize: 17, color: Colors.deepPurple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
