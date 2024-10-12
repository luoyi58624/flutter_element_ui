import 'package:element_plus/element_plus.dart';

abstract class ElAssert {
  /// Element UI 内部错误，这不是用来描述用户引发的错误，而是用来对某些代码期望值添加的一层防护措施。
  static String elementError(String message) {
    return 'Element UI 内部错误: $message';
  }

  /// 主题类型断言，要么传递空，要么必须是五种主题类型的其中一个
  static void themeType(String? type, String componentName) {
    assert(
        type == null || elThemeTypes.contains(type),
        '$componentName: 主题类型断言失败，你要么传递 null，'
        '要么传递 primary、success、info、warning、error 其中一个，'
        '但是得到的类型是: $type');
  }

  /// 主题类型断言，必须是五种主题类型的其中一个
  static void themeTypeRequired(String type, String componentName) {
    assert(
        elThemeTypes.contains(type),
        '$componentName: 主题类型断言失败，你必须传递 primary、success、info、warning、error 其中一个，'
        '但是得到的类型是: $type');
  }
}
