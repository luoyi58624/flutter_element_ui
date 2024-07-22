import 'package:flutter/material.dart';

import 'services/hover.dart';
import 'services/message.dart';
import 'services/toast.dart';

/// Element UI 全局服务对象
final $el = _ElService();

class _ElService with ElHoverService, ElMessageService, ElToastService {
  /// 根节点导航key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 全局 context 对象。
  ///
  /// 注：如果你将它用于依赖 [Overlay] 的弹窗api，你必须插入一个顶级遮罩：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) {
  ///     return Overlay(initialEntries: [
  ///       OverlayEntry(builder: (context) {
  ///         return child!;
  ///       }),
  ///     ]),
  ///   }
  /// );
  /// ```
  BuildContext get context {
    assert(
        navigatorKey.currentWidget != null &&
            navigatorKey.currentWidget is Navigator,
        '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 navigatorKey');
    return navigatorKey.currentContext!;
  }

  /// Element UI 颜色主题类型集合
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];
}
