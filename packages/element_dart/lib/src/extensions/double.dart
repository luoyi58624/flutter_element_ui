extension DartDoubleExtension on double {
  /// 将浮点数字转成 -128 ~ 127 范围的8位整数
  int get floatToInt8 => (this * 255.0).round() & 0xff;
}
