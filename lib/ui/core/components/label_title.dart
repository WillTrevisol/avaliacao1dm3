import 'package:flutter/material.dart';

class LabelTitle extends StatelessWidget {
  const LabelTitle({super.key, required this.text});
  
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}