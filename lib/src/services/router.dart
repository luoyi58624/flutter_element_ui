import 'package:flutter/material.dart';

mixin ElRouterService {
  /// 全局路由导航key，请一定要在顶级 App 中挂载此 key。
  ///
  /// 当使用命令式路由：
  /// ```dart
  /// MaterialApp(
  ///   navigatorKey: el.navigatorKey,
  /// );
  /// ```
  ///
  /// 当使用声明式路由（以官方提供的 go_router 为例子）：
  /// ```dart
  /// final router = GoRouter(
  ///   navigatorKey: el.navigatorKey,
  /// );
  /// ```
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// Element UI 全局路由导航 context 对象。
  ///
  /// 注意：它只能用于全局导航，同时你必须对 Flutter 上下文有一定的了解，否则请不要滥用它。
  // 还有一点：不要将它用于访问 [InheritedWidget] 小部件，因为这样做是不会注册依赖关系，
  // 只有通过当前组件本身的 context 访问才能与目标 [InheritedWidget] 进行依赖绑定，
  // 最常见的例子就是切换黑暗模式，如果代码中使用 el.context.isDark 访问当前是否是黑暗模式，
  // 那么目标小部件将不会发生任何变化，因为使用 el.context 只是将 Navigator 与 BrightnessWidget 进行绑定。
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
