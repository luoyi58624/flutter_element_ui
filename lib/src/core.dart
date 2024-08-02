import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';

import 'components/basic/scrollbar.dart';
import 'services/hover.dart';
import 'services/message/message.dart';
import 'services/toast.dart';
import 'styles/config.dart';
import 'styles/theme.dart';
import 'utils/font.dart';
import 'widgets/animation.dart';

class ElConfigProvider extends StatelessWidget {
  /// Element UI 全局配置注入：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElConfigProvider(
  ///     child: child!,
  ///   ),
  /// ),
  /// ```
  const ElConfigProvider({
    super.key,
    required this.child,
    this.behavior = const ElScrollBehavior(),
  });

  final Widget child;

  /// 自定义全局滚动行为，默认实现是 [ScrollBehavior]
  final ScrollBehavior behavior;

  @override
  Widget build(BuildContext context) {
    // 初始化全局文本样式
    el.initGlobalTextStyle(context);
    // 有些组件是直接基于 Material 进行二次封装的，所以需要构建一个默认的 Material 组件，防止报错
    return Material(
      textStyle: el.globalTextStyle,
      // 设置背景颜色
      child: AnimatedColoredBox(
        duration: el.config.colorDuration,
        color: context.elTheme.bgColor,
        // 设置全局滚动配置
        child: ScrollConfiguration(
          behavior: behavior,
          // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等 api 时会报错
          child: Overlay(initialEntries: [
            OverlayEntry(builder: (context) {
              return child;
            }),
          ]),
        ),
      ),
    );
  }
}

/// Element UI 全局服务对象
final el = ElService();

class ElService with ElHoverService, ElMessageService, ElToastService {
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
class ElResponsiveData {
  /// 特小号设备最大尺寸
  final double xs;

  /// 移动设备最大尺寸
  final double sm;

  /// 平板设备最大尺寸
  final double md;

  /// 桌面设备最大尺寸
  final double lg;

  /// 大屏桌面设备最大尺寸
  final double xl;

  const ElResponsiveData({
    this.xs = 320,
    this.sm = 640,
    this.md = 1024,
    this.lg = 1920,
    this.xl = 2560,
  });

  ElResponsiveData copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ElResponsiveData(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }
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
