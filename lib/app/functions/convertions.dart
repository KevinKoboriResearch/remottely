import 'package:flutter/material.dart';

Color convertStringToColor(value) {
  final Color otherColor = Color(
    int.parse(value.toString().split('(0x')[1].split(')')[0], radix: 16),
  );
  return otherColor;
}
