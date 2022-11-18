import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice3/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 17, 45)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 65,
            child: Image(
              image: AssetImage('assets/app-logo.png'),
              height: 100,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            'Consistency Tracker',
            style: GoogleFonts.robotoMono(
                fontSize: 20.0,
                color: Colors.grey[200],
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}
