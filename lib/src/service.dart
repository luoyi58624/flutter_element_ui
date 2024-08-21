import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'services/context_menu.dart';
import 'services/cursor.dart';
import 'services/message.dart';
import 'services/toast.dart';
import 'styles/config.dart';
import 'styles/theme.dart';

/// Element UI 全局服务对象
final el = ElService();

class ElService
    with
        ElContextMenuService,
        ElCursorService,
        ElMessageService,
        ElToastService {
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

  /// Element UI 颜色主题类型集合，因为枚举有点繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// Element UI 全局亮色主题
  ElThemeData theme = ElThemeData();

  /// Element UI 全局暗色主题
  ElThemeData darkTheme = ElThemeData.dark();

  /// Element UI 全局配置
  ElConfigData config = ElConfigData.data;

  /// Element UI 全局响应式断点配置
  ElResponsiveData responsive = const ElResponsiveData();

  /// 全局文本尺寸
  late double globalFontSize;
}

/// 响应式配置
class ElResponsiveData extends ResponsiveData {
  const ElResponsiveData({super.xs, super.sm, super.md, super.lg, super.xl});
}
