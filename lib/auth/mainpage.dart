import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice3/screens/splashscreen.dart';
import 'authpage.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // check if user has logged in or not
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // if yes then directly open the Home page
          return const SplashScreen();
        } else {
          // else let the user sign in or sign up
          return const AuthPage();
        }
      },
    );
  }
}
