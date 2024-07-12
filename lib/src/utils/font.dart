import 'package:flutter/widgets.dart';

/// Element UI 字重，之所以不直接使用 [FontWeight] 是因为有时候希望能更改全局字重，
/// 例如 normal -> w500，bold -> w600 等等
class ElFontWeight {
  ElFontWeight._();

  static FontWeight normal = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight bold = FontWeight.w700;
}
