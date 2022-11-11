import 'package:flutter/material.dart';
import 'package:practice3/chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice3/loading.dart';
import 'package:practice3/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/chart': (context) => Chart(),
        '/loading': (context) => LoadingScreen(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(0, 25, 65, 1),
        ),
        // scaffoldBackgroundColor: Color.fromARGB(255, 16, 9, 47),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: const Color.fromARGB(
                255, 16, 9, 47), // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          // headline1: TextStyle(color: Colors.deepPurpleAccent),
          // headline2: TextStyle(color: Colors.deepPurpleAccent),

          // bodytext2: screen pe jitna bhi color hai usko white color diya
          bodyText2: TextStyle(color: Color.fromRGBO(0, 25, 65, 1)),

          // textfield me jo text likhne me ata uska color
          subtitle1: TextStyle(color: Color.fromARGB(255, 16, 9, 47)),
        ),
      ),
    ),
  );
}
