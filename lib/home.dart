import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  var textinput = TextEditingController();

  var borderColor;

  String input = '';

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consistency Tracker'),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 25.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 60,
              ),
              Text('Welcome again!',
                  style: GoogleFonts.lato(
                      fontSize: 40, fontWeight: FontWeight.bold)),
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
                    child: Text(
                      'submit',
                      style: GoogleFonts.lato(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 200),

              // direct view graph
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightGreen),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/loading',
                      arguments: {'isempty': 'yes'});
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      textAlign: TextAlign.center,
                      'View this week\'s consistency graph',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
