import 'package:flutter/material.dart';

mixin RouterService {
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
  /// 注意：它只能用于全局导航、或者在页面上显示弹窗，请不要滥用它。
  // 还有一个十分常见的坑需要注意一下，就是不要将它用于访问 InheritedWidget 小部件，
  // 例如使用全局 context 判断暗黑模式：el.context.isDark；
  //
  // 这样做的弊端在于，当我们访问 InheritedWidget 小部件的数据时，是通过 context 调用
  // dependOnInheritedWidgetOfExactType 方法，这个 api 除了返回数据之外，
  // 更重要的一点是注册依赖关系，当数据发生改变时，会通知依赖它的小部件执行重建，
  // 如果你使用全局 context 访问数据，由于全局 context 来自于 Navigator 导航器，
  // 所以注册的依赖将变成 Navigator 与 InheritedWidget，当数据发生变更时，
  // 只会通知 Navigator 重建，而不会通知目标小部件重建，导致页面不会发生任何变化。
  //
  // 这也是为什么 Element UI 很多扩展方法都要求你必须传递当前 context，而不是在内部直接使用全局 context 的原因。
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
