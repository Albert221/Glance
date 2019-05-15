import 'package:flutter/material.dart';

class FullscreenProgressIndicator extends StatelessWidget {
  const FullscreenProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
