import 'package:flutter/material.dart';

class ReddigramTheme {
  static ThemeData light() {
    final lightTheme = ThemeData.light();

    return lightTheme.copyWith(
      primaryColor: Colors.black,
      accentColor: Colors.black,
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
      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
      ),
      textTheme: lightTheme.textTheme.copyWith(
        caption: TextStyle(
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

  static ThemeData dark() {
    final lightTheme = ThemeData.dark();

    return lightTheme.copyWith(
      accentColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        textTheme: TextTheme(
          display1: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.normal,
            fontFamily: 'Pacifico',
          ),
        ),
      ),
      textTheme: lightTheme.textTheme.copyWith(
        caption: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        body1: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
      ),
      cardColor: Colors.black,
    );
  }
}
