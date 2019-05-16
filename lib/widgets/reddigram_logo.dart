import 'package:flutter/material.dart';

class ReddigramLogo extends StatelessWidget {
  const ReddigramLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Reddigram',
      style: TextStyle(
        fontFamily: 'Pacifico',
        fontSize: 22.0,
        fontWeight: Theme.of(context).brightness == Brightness.light
            ? FontWeight.bold
            : FontWeight.normal,
      ),
    );
  }
}
