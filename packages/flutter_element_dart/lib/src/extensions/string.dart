import 'package:flutter_element_dart/src/utils/reg.dart';

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

  /// 清除字符串首尾空格
  String get clearFrontBackBlank {
    return replaceAll(RegUtil.removeFirstBlank, '')
        .replaceAll(RegUtil.removeEndBlank, '')
        .trim();
  }

  /// 提取类型字符串的泛型类型
  String? get toGenericType {
    int start = indexOf('<') + 1;
    int end = lastIndexOf('>');
    if (start >= end) return null;
    return substring(indexOf('<') + 1, lastIndexOf('>'));
  }

  /// 提取 Map 类型字符串的泛型类型，返回一个 Record 类型字符串集合
  ({String key, String value})? get toMapGenericType {
    int start = indexOf('<') + 1;
    int end = lastIndexOf('>');

    if (start >= end) return null;

    List<String> typeList =
        substring(indexOf('<') + 1, lastIndexOf('>')).split(',');
    if (typeList.length != 2) return null;

    return (key: typeList[0], value: typeList[1]);
  }
}
