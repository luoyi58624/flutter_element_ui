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

  static String getListGeneric(String type) {
    if (type.contains('String')) {
      return 'String';
    } else if (type.contains('num')) {
      return 'num';
    } else if (type.contains('int')) {
      return 'int';
    } else if (type.contains('double')) {
      return 'double';
    } else if (type.contains('bool')) {
      return 'bool';
    }
    return 'dynamic';
  }

  static String getMapGeneric(String type) {
    var index = type.indexOf(',');
    var str = type.substring(index + 1, type.length).trim();
    return str.substring(0, str.length - 1);
  }
}
