class CommonUtil {
  CommonUtil._();

  static String firstLowerCase(String str) {
    return str.substring(0, 1).toLowerCase() + str.substring(1);
  }

  /// 将驼峰命名字符串转成下划线
  static String toUnderline(String str) {
    return str
        .replaceAllMapped(
          RegExp('(?<=[a-z])[A-Z]'),
          (m) => '_${m.group(0)}',
        )
        .toLowerCase();
  }
}
