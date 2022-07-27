import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future SignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Something Erro',
            desc: 'Error: $e',
            )..show();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Welcome user
                SizedBox(
                  height: 40,
                ),
                Text('Hello Again!',
                    style: GoogleFonts.bebasNeue(fontSize: 55)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: GoogleFonts.bebasNeue(fontSize: 28),
                ),

                // Text Field
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        icon: Icon(Icons.email),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      icon: Icon(Icons.lock),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await SignIn();
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
                        "Sign In",
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.showRegisterPage,
                  child: Text(
                    "Not a member? Register Now",
                    style: TextStyle(fontSize: 17, color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
