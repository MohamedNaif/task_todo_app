import 'package:flutter/material.dart';

abstract class AppStyle {
  static const primaryColor = Color(0xFF5F33E1);

  static TextStyle textStyle24() {
    return const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textStyle14() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textStyle12() {
    return const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(47, 47, 47, 0.4));
  }

  static TextStyle textStyle19() {
    return const TextStyle(
        fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white);
  }
}
