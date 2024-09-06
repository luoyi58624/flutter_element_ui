import 'package:flutter/material.dart';

mixin ElRouterService {
  /// 根节点路由导航key，请一定要挂载此 key，否则当使用依赖 [Overlay]、[Router] 等 api 时将报错。
  ///
  /// 当使用命令式路由：
  /// ```dart
  /// MaterialApp(
  ///   navigatorKey: el.navigatorKey,
  /// );
  /// ```
  ///
  /// 当使用声明式路由（官方提供的 go_router 例子）：
  /// ```dart
  /// final router = GoRouter(
  ///   navigatorKey: el.navigatorKey,
  /// );
  /// ```
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// Element UI 全局 context 对象
  BuildContext get context {
    assert(() {
      if (navigatorKey.currentWidget == null ||
          navigatorKey.currentWidget is! Navigator) {
        throw FlutterError('Element UI 全局 context 未初始化，'
            '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 el.navigatorKey');
      }
      return true;
    }());
    return navigatorKey.currentContext!;
  }
}
