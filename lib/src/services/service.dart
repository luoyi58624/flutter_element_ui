import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'cursor.dart';
import 'message/message.dart';
import 'toast.dart';
import '../styles/config.dart';
import '../styles/theme.dart';
import '../utils/font.dart';

/// Element UI 全局服务对象
final el = ElService();

class ElService with ElCursorService, ElMessageService, ElToastService {
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
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 全局 context 对象
  BuildContext get context {
    assert(
        navigatorKey.currentWidget != null &&
            navigatorKey.currentWidget is Navigator,
        '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 navigatorKey');
    return navigatorKey.currentContext!;
  }

  /// Element UI 颜色主题类型集合，因为枚举有点繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// 亮色主题
  ElThemeData theme = ElThemeData();

  /// 暗色主题
  ElThemeData darkTheme = ElThemeData.dark();

  /// 全局配置
  ElConfigData config = ElConfigData();

  /// 全局响应式断点配置
  ElResponsiveData responsive = const ElResponsiveData();

  /// 全局文本排版配置
  ElTypographyData typography = ElTypographyData.data;

  TextStyle _globalTextStyle = const TextStyle();

  /// 全局文本样式
  TextStyle get globalTextStyle => _globalTextStyle;

  /// 初始化全局文本样式，先创建包含颜色、尺寸、粗细等默认样式，再合并用户配置的样式
  void initGlobalTextStyle(BuildContext context) {
    el._globalTextStyle = TextStyle(
      color: context.elTheme.textColor,
      fontSize: el.typography.text,
      fontWeight: ElFont.normal,
    ).merge(el.config.textStyle);
  }
}

/// 响应式配置
class ElResponsiveData extends ResponsiveData {
  const ElResponsiveData({super.xs, super.sm, super.md, super.lg, super.xl});
}

/// 字体排版配置
class ElTypographyData {
  /// 默认的字体排版配置
  static final data = ElTypographyData(
    h1: 28,
    h2: 24,
    h3: 20,
    h4: 18,
    h5: 16,
    h6: 14,
    text: 15,
  );

  /// 一级标题
  final double h1;

  /// 二级标题
  final double h2;

  /// 三级标题
  final double h3;

  /// 四级标题
  final double h4;

  /// 五级标题
  final double h5;

  /// 六级标题
  final double h6;

  /// 普通文本
  final double text;

  final Widget Function(BuildContext context, String)? builder;

  ElTypographyData({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.text,
    this.builder,
  });

  ElTypographyData copyWith({
    double? h1,
    double? h2,
    double? h3,
    double? h4,
    double? h5,
    double? h6,
    double? text,
    Color? hrefColor,
    bool? underline,
    bool? hoverUnderline,
  }) {
    return ElTypographyData(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      text: text ?? this.text,
    );
  }
}
