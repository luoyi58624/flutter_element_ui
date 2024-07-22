import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:flutter_element_ui/src/utils/font.dart';
import 'package:flutter_element_ui/src/utils/icons.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:gap/gap.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

import 'components/basic/icon.dart';
import 'components/others/hover.dart';

part 'services/hover.dart';

part 'services/message.dart';

part 'services/toast.dart';

/// Element UI 全局服务对象
final $el = _ElService();

class _ElService with _HoverService, _MessageService, _ToastService {
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
