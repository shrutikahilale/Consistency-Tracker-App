// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpPage({super.key, required this.showLoginPage});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isNotVisible = true;

  final fullnameinput = TextEditingController();
  final ageinput = TextEditingController();
  final emailinput = TextEditingController();
  final password1input = TextEditingController();
  final password2input = TextEditingController();

  @override
  void dispose() {
    fullnameinput.dispose();
    ageinput.dispose();
    emailinput.dispose();
    password1input.dispose();
    password2input.dispose();
    super.dispose();
  }

  Future register() async {
    if (allfieldsfilled() && passwordCheck()) {
      try {
        // create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailinput.text.trim(),
          password: password1input.text.trim(),
        );

        // add user details
        addUser(fullnameinput.text.trim(), emailinput.text.trim(),
            int.parse(ageinput.text.trim()));

        
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }),
        );
      }
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

  Future addUser(String name, String email, int age) async {
    // database
    final db = FirebaseFirestore.instance;

    // users collection
    CollectionReference users = db.collection('users');

    // add user to collection and set email ID as doc ID for the user
    final userid = email;

    await users.doc(userid).set({
      'name': name,
      'email': email,
      'age': age,
    });

    // add hours collection to userId document then add 7 documents for each day
    final hours = users.doc(userid).collection('hours');
    for (int i = 0; i < 7; i++) {
      await hours.doc(i.toString()).set({'day': i, 'hours': 0});
    }
  }

  bool allfieldsfilled() {
    if (emailinput.text.isNotEmpty &&
        password1input.text.isNotEmpty &&
        password2input.text.isNotEmpty &&
        fullnameinput.text.isNotEmpty) {
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
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 80,
                  child: Image(
                    image: AssetImage('assets/app-logo-no-bg.png'),
                  ),
                ),

                // welcome text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Welcome to Consistency Tracker!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: fullnameinput,
                      cursorColor: Color.fromARGB(255, 16, 9, 47),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Full Name *",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                // first name

                SizedBox(
                  height: 10,
                ),

                // age
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Flexible(
                      child: TextField(
                        controller: ageinput,
                        cursorColor: Color.fromARGB(255, 16, 9, 47),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Age",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: emailinput,
                      cursorColor: Color.fromARGB(255, 16, 9, 47),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email id *",
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
                    padding: EdgeInsets.only(left: 10),
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
                              hintText: "Password *",
                              border: InputBorder.none,
                            ),
                            obscureText: isNotVisible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isNotVisible =
                                    isNotVisible == true ? false : true;
                              });
                            },
                            child: Icon(
                              isNotVisible == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                    padding: EdgeInsets.only(left: 10),
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
                              hintText: "Confirm password *",
                              border: InputBorder.none,
                            ),
                            obscureText: isNotVisible,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isNotVisible =
                                    isNotVisible == true ? false : true;
                              });
                            },
                            child: Icon(
                              isNotVisible == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                  height: 40,
                ),
                // not a member? register now!

                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(117, 245, 245, 245),
                  ),
                ),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: Text(
                    'Sign in here!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 72, 235, 77),
                    ),
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
