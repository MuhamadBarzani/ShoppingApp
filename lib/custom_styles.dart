import 'package:flutter/material.dart';

class CustomTextStyles {
  static const TextStyle shadowedText = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(blurRadius: 10.0, color: Colors.yellow, offset: Offset(0, 0)),
      Shadow(blurRadius: 20.0, color: Colors.black, offset: Offset(0, 0)),
      Shadow(blurRadius: 30.0, color: Colors.black, offset: Offset(0, 0)),
    ],
  );
}