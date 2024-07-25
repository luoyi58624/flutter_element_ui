import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';

import 'components/basic/scrollbar.dart';
import 'services/hover.dart';
import 'services/message/message.dart';
import 'services/toast.dart';
import 'styles/config.dart';
import 'styles/theme.dart';
import 'widgets/animation.dart';

class ElConfigProvider extends StatelessWidget {
  /// Element UI 配置注入，它是可选的，你可以完全自定义它们：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElConfigProvider(
  ///     child: child!,
  ///   ),
  /// ),
  /// ```
  const ElConfigProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // 管理全局光标，Element UI 所有 hover 效果都依赖此组件
    return ElGlobalCursor(
      // 设置全局文本样式，先创建只包含主题文字颜色样式，再合并用户配置的默认文本样式。
      // 提示：它不会继承祖先默认文本样式，防止祖先样式污染，黄色双下划线便是从 MaterialApp 注入的。
      child: DefaultTextStyle(
        style: TextStyle(color: context.elTheme.textColor)
            .merge(el.config.textStyle),
        // 设置背景颜色
        child: AnimatedColoredBox(
          duration: el.config.bgTransition.ms,
          color: context.elTheme.bgColor,
          // 设置默认滚动条，Element UI样式
          child: ScrollConfiguration(
            behavior: const ElScrollBehavior(),
            // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等浮层时会报错
            child: Overlay(initialEntries: [
              OverlayEntry(builder: (context) {
                return child;
              }),
            ]),
          ),
        ),
      ),
    );
  }
}

/// Element UI 全局服务对象
final el = _ElService();

// ============================================================================
// 之前使用 InheritedWidget 去注入全局配置信息，使用一段时间后发现这种行为就是多此一举，
// InheritedWidget 更适合为局部提供默认状态，通过当前上下文 context 访问最近的配置信息，
// 可以完美地实现数据隔离，不会引起冲突，但这种特性对于全局数据来讲将失去意义，没有哪个应用
// 会创建多种相互隔离的主题模式，因为这种行为几乎等同于你在一个 App 中创建多个 MaterialApp，
// 至少就目前来讲，这是一种反模式，会引发各种问题。
//
// 在 Flutter 中，数据和 UI 是完全解耦的，无论你将数据放在哪里，对数据做了什么操作，
// 如果需要刷新页面只需调用一次 setState 即可，抛弃 InheritedWidget 管理全局数据，
// 你可以在任意地方去使用它，而无需通过 context 上下文查找。
// ===========================================================================
class _ElService with ElHoverService, ElMessageService, ElToastService {
  /// 亮色主题
  ElThemeData lightTheme = ElThemeData();

  /// 暗色主题
  ElThemeData darkTheme = ElThemeData.dark();

  /// 组件配置
  ElConfigData config = ElConfigData();

  /// 响应式断点配置
  ElResponsiveData responsive = const ElResponsiveData();

  /// 文本排版配置，
  ElTypographyData typography = ElTypographyData.data;

  /// Element UI 颜色主题类型集合，因为枚举有点繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// 根节点导航key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 全局 context 对象
  BuildContext get context {
    assert(
        navigatorKey.currentWidget != null &&
            navigatorKey.currentWidget is Navigator,
        '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 navigatorKey');
    return navigatorKey.currentContext!;
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

  /// 超链接文本颜色，默认跟随主题色
  final Color? hrefColor;

  /// 超链接是否显示下划线
  final bool underline;

  /// 是否在鼠标悬停时显示下划线，默认false，若为true，[underline]将无效
  final bool hoverUnderline;

  ElTypographyData({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.text,
    this.hrefColor,
    this.underline = true,
    this.hoverUnderline = false,
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
      hrefColor: hrefColor ?? this.hrefColor,
      underline: underline ?? this.underline,
      hoverUnderline: hoverUnderline ?? this.hoverUnderline,
    );
  }
}
