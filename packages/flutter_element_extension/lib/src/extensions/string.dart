extension DartStringExtension on String {
  /// 首字母大写
  String get firstUpperCase {
    return substring(0, 1).toUpperCase() + substring(1);
  }

  /// 首字母小写
  String get firstLowerCase {
    return substring(0, 1).toLowerCase() + substring(1);
  }

  /// 将驼峰命名字符串转成下划线
  String get toUnderline {
    return replaceAllMapped(
      RegExp('(?<=[a-z])[A-Z]'),
      (m) => '_${m.group(0)}',
    ).toLowerCase();
  }
}
