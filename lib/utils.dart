import 'package:flutter/material.dart';
import 'dart:math';

Color randomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255, // Opacity
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
  );
}
