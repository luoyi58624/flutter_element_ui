import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

mixin RouterService {
  /// 全局路由导航key
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Element UI 全局路由导航 context 对象
  BuildContext get context {
    assert(() {
      if (navigatorKey.currentWidget == null ||
          navigatorKey.currentWidget is! Navigator) {
        throw FlutterError('Element UI 全局 routerContext 未初始化，'
            '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 el.navigatorKey');
      }
      return true;
    }());
    return navigatorKey.currentContext!;
  }
}
