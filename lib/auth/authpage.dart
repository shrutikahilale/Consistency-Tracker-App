import 'package:flutter/material.dart';
import 'package:practice3/auth/login.dart';
import 'package:practice3/auth/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initilaly show login page
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage == true
        ? LoginPage(showSignupPage: toggleScreens)
        : SignUpPage(showLoginPage: toggleScreens);
  }
}
