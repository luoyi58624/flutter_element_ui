import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

part 'services/hover.dart';

part 'services/message.dart';

part 'services/toast.dart';

/// Element UI 全局服务对象
final $el = _ElService();

class _ElService with _HoverService, _MessageService, _ToastService {
  /// 根节点导航key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 根节点路由 context 对象
  BuildContext get context {
    assert(
        navigatorKey.currentWidget != null &&
            navigatorKey.currentWidget is Navigator,
        '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 navigatorKey');
    return navigatorKey.currentContext!;
  }

  // 全局 context 和局部 context 的区别：
  // 使用全局 context 弹窗会相对于整个 App 界面，它的层级非常高，几乎在所有页面元素之上
  // 使用局部 context 弹窗会相对于当前路由页面，因为 Navigator 会自动插入 Overlay 组件
  BuildContext? _overlayContext;

  /// 全局遮罩 context 对象
  BuildContext get overlayContext {
    assert(
        _overlayContext != null, 'overlayContext 为空，请在顶级 App 中构建 Overlay 组件');
    return _overlayContext!;
  }

  /// 设置全局遮罩 context 对象：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) {
  ///     return Overlay(initialEntries: [
  ///       OverlayEntry(builder: (context) {
  ///         $el.overlayContext = context;
  ///         return child!;
  ///       }),
  ///     ]),
  ///   }
  /// );
  /// ```
  set overlayContext(BuildContext context) {
    _overlayContext = context;
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
