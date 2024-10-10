class RegUtil {
  RegUtil._();

  /// 移除字符串前面空格
  static RegExp removeFirstBlank = RegExp(r'^\s*');

  /// 移除字符串后面空格
  static RegExp removeEndBlank = RegExp(r'\s*$');

  /// 匹配 html 标签
  static RegExp htmlTag = RegExp(r'<(.|\n)*?>');
}
