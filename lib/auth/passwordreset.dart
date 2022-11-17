// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final emailinput = TextEditingController();

  @override
  void dispose() {
    emailinput.dispose();
    super.dispose();
  }

  Future passwordreset() async {
    try {
      await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailinput.text.trim());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Reset link sent to your email'),
        );
      },
    );
    }on FirebaseAuthException catch (e) {
      showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      },
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter email id to get a reset password link',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            // email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: emailinput,
                  cursorColor: Color.fromARGB(255, 16, 9, 47),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email id",
                    prefixIcon: Icon(
                      Icons.alternate_email,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: passwordreset,
              child: Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ),
              color: Color.fromARGB(255, 28, 109, 231),
            )
          ],
        ),
      ),
    );
  }
}
