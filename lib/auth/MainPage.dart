import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Views/NavigationBar.dart';
import 'AuthPage.dart';


class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NavigationBarPage();
            } else {
              return AuthPage();
            }
          }),
    );
  }
}