import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();

  static const MaterialColor blue = Colors.blue;
  static const MaterialColor green = Colors.green;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const MaterialColor yellow = Colors.yellow;
  static const MaterialColor red = Colors.red;

  static const Color darkGrey = const Color(0xFF505050);
  static const MaterialColor grey = Colors.grey;
  static const Color lightGrey = const Color(0xFFDCDCDC);

  static getColorForCompletion(double percentage) {
    if (percentage > 66) {
      return green;
    }

    if (percentage > 33) {
      return yellow;
    }

    return red;
  }
}
