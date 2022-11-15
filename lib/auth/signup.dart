// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isNotVisible1 = true;
  bool isNotVisible2 = true;

  late TextEditingController emailinput;
  late TextEditingController password1input;
  late TextEditingController password2input;

  @override
  void initState() {
    super.initState();
    emailinput = TextEditingController();
    password1input = TextEditingController();
    password2input = TextEditingController();
  }

  @override
  void dispose() {
    emailinput.dispose();
    password1input.dispose();
    password2input.dispose();
    super.dispose();
  }

  Future register() async {
    if (allfieldsfilled() && passwordCheck()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailinput.text.trim(),
        password: password1input.text.trim(),
      );

      Navigator.pushReplacementNamed(context, '/login');
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: emailinput.text.trim(),
      //   password: password1input.text.trim(),
      // );
    } else if (!passwordCheck()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords don\'t match!'),
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 1000),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter all fields'),
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 1000),
        ),
      );
    }
  }

  bool allfieldsfilled() {
    if (emailinput.text.isNotEmpty &&
        password1input.text.isNotEmpty &&
        password2input.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool passwordCheck() {
    if (password1input.text.isNotEmpty &&
        password1input.text.trim() == password2input.text.trim()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // welcome text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Welcome to Consistency Tracker!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Create an awesome account!'),

                const SizedBox(
                  height: 100,
                ),

                // email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: emailinput,
                      cursorColor: Color.fromARGB(255, 16, 9, 47),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your email id",
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

                // password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: password1input,
                            cursorColor: Color.fromARGB(255, 16, 9, 47),
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              border: InputBorder.none,
                            ),
                            obscureText: isNotVisible1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isNotVisible1 =
                                    isNotVisible1 == true ? false : true;
                              });
                            },
                            child: Icon(
                              isNotVisible1 == true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: password2input,
                            cursorColor: Color.fromARGB(255, 16, 9, 47),
                            decoration: InputDecoration(
                              hintText: "Confirm password",
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              border: InputBorder.none,
                            ),
                            obscureText: isNotVisible2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isNotVisible2 =
                                    isNotVisible2 == true ? false : true;
                              });
                            },
                            child: Icon(
                              isNotVisible2 == true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                // sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: register,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 28, 109, 231),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Create account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // not a member? register now!

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(117, 245, 245, 245),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/login');
                      },
                      child: Text(
                        'Sign in here!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 72, 235, 77),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
