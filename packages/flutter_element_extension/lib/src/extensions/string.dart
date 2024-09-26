extension DartStringExtension on String {
  /// 首字母大写
  String get firstUpperCase {
    return substring(0, 1).toUpperCase() + substring(1);
  }

  /// 首字母小写
  String get firstLowerCase {
    return substring(0, 1).toLowerCase() + substring(1);
  }
}
