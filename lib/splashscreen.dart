import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice3/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/app-logo.png'),
            height: 100,
          ),
          Text(
            'Consistency Tracker',
            style: GoogleFonts.robotoMono(
              fontSize: 24.0,
              color: Colors.cyan,
              decoration:  TextDecoration.none
            ),
          ),
        ],
      ),
    );
  }
}
