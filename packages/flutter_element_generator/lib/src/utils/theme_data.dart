/// Element UI 主题配置工具函数
class ThemeDataUtil {
  ThemeDataUtil._();

  /// Element 组件命名前缀
  static const String prefix = 'El';

  /// Element 组件主题数据后缀
  static const String suffix = 'ThemeData';

  /// 过滤前缀和后缀，获取单纯的组件名字，例如：
  /// * ElButtonThemeData -> Button
  /// * ElLinkThemeData -> Link
  static String getRawName(String className) {
    String rawName = className;
    if (rawName.startsWith(prefix)) {
      rawName = rawName.substring(prefix.length);
    }
    if (rawName.endsWith(suffix)) {
      rawName = rawName.substring(0, rawName.lastIndexOf(suffix));
    }
    return rawName;
  }
}
