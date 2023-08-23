// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromARGB(197, 106, 228, 206);
const COLOR_SECONDARY = Color.fromARGB(255, 225, 243, 215);
const COLOR_BLACK = Colors.black;
const COLOR_GREY = Color.fromRGBO(141, 141, 141, 1.0);
const COLOR_WHITE = Colors.white;

ThemeData getApplicationTheme() {
  return ThemeData(
      primarySwatch: Colors.green,
      fontFamily: 'OpenSans Regular',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'OpenSans Bold'),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),

      //text button
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.green,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: COLOR_PRIMARY, width: 1.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: COLOR_PRIMARY, width: 1.0)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      hintColor: COLOR_WHITE,

      //Appbar
      appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: COLOR_WHITE,
          foregroundColor: COLOR_BLACK,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)));
}

TextTheme textTheme() {
  return const TextTheme(
    titleLarge: TextStyle(
        color: Color.fromARGB(249, 10, 10, 10),
        fontSize: 28,
        fontWeight: FontWeight.w800),
  );
}
