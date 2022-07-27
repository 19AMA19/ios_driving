import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../appBrain.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('userData')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 242, 242),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 5)),
                      child: CircleAvatar(
                        radius: 80,
                        foregroundImage: NetworkImage(data['imageUrl']),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      data['fullname'],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data['email'],
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.verified, color: Colors.green),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        leading: Icon(Icons.account_box),
                        title: Text('Update My Profile'),
                        trailing: Icon(Icons.keyboard_double_arrow_right),
                        onTap: () {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        leading: Icon(Icons.light_mode),
                        title: Text('Dark Mode'),
                        trailing: ToggleSwitch(
                          activeBgColor:[ Colors.white],
                          minWidth: 40,
                          minHeight: 30,
                          icons: [
                            (Icons.sunny),
                            (Icons.mode_night_sharp),
                          ],
                          activeBgColors: [
                            [Colors.amber],
                            [Colors.blue],
                          ],
                          
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        leading: Icon(Icons.language),
                        title: Text('Change Language'),
                        trailing: Icon(Icons.keyboard_double_arrow_right),
                        onTap: () {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                        trailing: Icon(Icons.keyboard_double_arrow_right),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ),
     
      ),
    );
  }
}
