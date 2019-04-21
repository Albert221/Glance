import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reddigram'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Content!'),
      ),
    );
  }
}
