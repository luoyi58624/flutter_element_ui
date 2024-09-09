import 'package:flutter/material.dart';

mixin ElRouterService {
  /// 全局路由导航key，请一定要在顶级 App 中挂载此 key。
  ///
  /// 当使用命令式路由：
  /// ```dart
  /// MaterialApp(
  ///   navigatorKey: el.routerKey,
  /// );
  /// ```
  ///
  /// 当使用声明式路由（以官方提供的 go_router 为例子）：
  /// ```dart
  /// final router = GoRouter(
  ///   navigatorKey: el.routerKey,
  /// );
  /// ```
  final GlobalKey<NavigatorState> routerKey = GlobalKey();

  /// Element UI 全局路由导航 context 对象
  BuildContext get context {
    assert(() {
      if (routerKey.currentWidget == null ||
          routerKey.currentWidget is! Navigator) {
        throw FlutterError('Element UI 全局 routerContext 未初始化，'
            '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 el.routerKey');
      }
      return true;
    }());
    return routerKey.currentContext!;
  }

}
