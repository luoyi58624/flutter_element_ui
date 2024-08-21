import '../service.dart';

abstract class ElAssert {
  /// Element UI 内部错误
  static const String elementError = 'Element UI内部程序错误，此错误并非用户问题，请提交ISSUE';

  /// 主题类型断言，要么传递空，要么必须是五种主题类型的其中一个
  static void themeType(String? type, String componentName) {
    assert(
        type == null || el.themeTypes.contains(type),
        '$componentName: 主题类型断言失败，你要么传递 null，'
        '要么传递 primary、success、info、warning、error 其中一个，'
        '但是得到的类型是: $type');
  }

  /// 主题类型断言，必须是五种主题类型的其中一个
  static void themeTypeRequired(String type, String componentName) {
    assert(
        el.themeTypes.contains(type),
        '$componentName: 主题类型断言失败，你必须传递 primary、success、info、warning、error 其中一个，'
        '但是得到的类型是: $type');
  }
}
