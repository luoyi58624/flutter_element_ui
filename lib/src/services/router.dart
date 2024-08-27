import 'package:flutter/material.dart';
import 'package:flutter_element_ui/global.dart';

mixin ElRouterService {
  /// 根节点路由导航key，请务必挂载此 key。
  ///
  /// 当使用命令式路由：
  /// ```dart
  /// MaterialApp(
  ///   navigatorKey: el.navigatorKey,
  /// );
  /// ```
  ///
  /// 当使用声明式路由：
  /// ```dart
  /// final router = GoRouter(
  ///   navigatorKey: el.navigatorKey,
  /// );
  /// ```
  GlobalKey<NavigatorState> get navigatorKey => GlobalConfig.navigatorKey;

  /// 全局 context 对象
  BuildContext get context => GlobalConfig.context;
}