import 'package:flutter/material.dart';

class ReddigramTheme {
  static ThemeData theme() {
    return ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white,
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
          ),
        ),
      ),
    );
  }
}
