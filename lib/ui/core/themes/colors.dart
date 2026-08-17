import 'package:flutter/material.dart';

abstract final class AppColors {

  static const Color primary = Color.fromRGBO(218, 185, 255, 1);
  static const Color secondary = Color.fromRGBO(70, 245, 224, 1);
  static const Color red = Color.fromRGBO(147, 0, 10, 1);
  static const Color white = Colors.white;

  static final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: primary,
    secondary: secondary,
    onError: red,
    brightness: Brightness.dark
  );

}
