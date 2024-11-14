import 'package:flutter/material.dart';

extension FlutterIntExtension on int {
  /// int转[FontWeight]
  FontWeight toFontWeight([FontWeight? defaultFontWeight]) {
    switch (this) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
      default:
        return defaultFontWeight ?? FontWeight.normal;
    }
  }
}
