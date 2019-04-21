import 'package:flutter/material.dart';
import 'package:reddigram/theme.dart';
import 'package:reddigram/screens/screens.dart';

class ReddigramApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddigram',
      theme: ReddigramTheme.theme(),
      home: MainScreen(),
    );
  }
}
