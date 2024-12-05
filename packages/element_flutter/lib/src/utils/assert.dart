import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

abstract class ElAssert {
  /// Element UI 内部错误，这不是用来描述用户引发的错误，而是用来对某些代码期望值添加的一层防护措施。
  static String elementError(String message) {
    return 'Element UI 内部错误: $message';
  }

  /// 主题类型断言，要么传递空，要么必须是五种主题类型的其中一个
  static void themeType(String? type, String componentName) {
    assert(
        type == null || El.themeTypes.contains(type),
        '$componentName: 主题类型断言失败，你要么传递 null，'
        '要么传递 primary、success、info、warning、error 其中一个，'
        '但是得到的类型是: $type');
  }

  /// 主题类型断言，必须是五种主题类型的其中一个
  static void themeTypeRequired(String type, String componentName) {
    assert(
        El.themeTypes.contains(type),
        '$componentName: 主题类型断言失败，你必须传递 primary、success、info、warning、error 其中一个，'
        '但是得到的类型是: $type');
  }

  /// Element 全局导航器断言，如果没有配置全局导航 key，那么使用一些相关 Api 时将引起报错
  static void navigatorAssert() {
    assert(() {
      if (el.navigatorKey.currentWidget == null ||
          el.navigatorKey.currentWidget is! Navigator) {
        throw FlutterError('Element UI 全局 routerContext 未初始化，'
            '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 el.navigatorKey');
      }
      return true;
    }());
  }
}
