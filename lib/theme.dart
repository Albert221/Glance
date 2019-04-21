import 'package:flutter/material.dart';

class ReddigramTheme {
  static ThemeData theme() {
    final lightTheme = ThemeData.light();

    return lightTheme.copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        textTheme: TextTheme(
          display1: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
          ),
          title: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      textTheme: lightTheme.textTheme.copyWith(
        title: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        body1: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
