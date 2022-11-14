import 'package:flutter/material.dart';
import 'package:practice3/chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice3/home.dart';
import 'package:practice3/loading.dart';
import 'package:practice3/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      // home: SplashScreen(),
      routes: {
        '/chart': (context) => Chart(),
        '/loading': (context) => LoadingScreen(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 0, 0, 45),
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 54),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Color.fromARGB(255, 28, 109, 231), // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          // bodytext2: screen pe jitna bhi color hai usko white color diya
          bodyText2: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),

          // textfield me jo text likhne me ata uska color
          subtitle1: TextStyle(color: Color.fromARGB(255, 16, 9, 47)),
        ),
      ),
    ),
  );
}
