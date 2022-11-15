import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice3/screens/home.dart';
import 'package:practice3/auth/login.dart';
import 'package:practice3/screens/splashscreen.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // check if user has logged in or not
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // if yes then directly open the Home page
          print('home page');
          return Home();
        } else {
          // else let the user sign in or sign up
          print('login page');
          return LoginPage();
        }
      },
    );
  }
}
