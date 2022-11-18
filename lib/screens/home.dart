import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice3/auth/mainpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController textinput;
  String input = '';

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    textinput = TextEditingController();
  }

  @override
  void dispose() {
    textinput.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consistency Tracker'),
      ),
      drawer: const Icon(Icons.menu),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 25.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Have an amazing day!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                      controller: textinput,
                      // receive only numerical input
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'How many hours did you work today?',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(158, 16, 9, 47),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(),
                    onPressed: () {
                      input = textinput.text;
                      double input_ = double.parse(input);

                      if (input_ > 0 && input_ < 15) {
                        // pass input to chart.dart
                        Navigator.pushNamed(context, '/loading',
                            arguments: {'input': input});

                        // clear the textfield
                        textinput.clear();
                      } else {
                        // validity checking
                        // show snackbar on wrong input
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Row(
                                children: input_ >= 15
                                    ? const [
                                        Icon(
                                          Icons.close_sharp,
                                          color: Colors.white,
                                        ),
                                        Flexible(
                                          child: Text(
                                              'That\'s too much! Please enter value less than 15'),
                                        ),
                                      ]
                                    : const [
                                        Icon(
                                          Icons.alarm,
                                          color: Colors.white,
                                        ),
                                        Text('Hours can\'t be negative!!'),
                                      ],
                              ),
                              duration: const Duration(milliseconds: 1500),
                              backgroundColor: Colors.redAccent),
                        );
                      }
                    },
                    child: const Text(
                      'submit',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 150),

              // direct view graph
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightGreen),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/loading',
                      arguments: {'input': 0});
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      textAlign: TextAlign.center,
                      'View this week\'s consistency graph',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ),
              ),

              const SizedBox(height: 120),

              // sign out button
              ElevatedButton(
                onPressed: _signOut,
                child: Text('Sign out'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
