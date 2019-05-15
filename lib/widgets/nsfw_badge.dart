import 'package:flutter/material.dart';

class NsfwBadge extends StatelessWidget {
  const NsfwBadge({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: const Text(
        '18+',
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
