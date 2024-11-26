import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    primaryColor: Colors.grey.shade400,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
    )
);


ThemeData darkMode = ThemeData(
  primaryColor: Colors.grey.shade900,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), 
  )
);