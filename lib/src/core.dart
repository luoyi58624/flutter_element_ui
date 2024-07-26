import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';

import 'components/basic/scrollbar.dart';
import 'components/basic/typography.dart';
import 'services/hover.dart';
import 'services/message/message.dart';
import 'services/toast.dart';
import 'styles/config.dart';
import 'styles/theme.dart';
import 'utils/font.dart';
import 'widgets/animation.dart';

class ElConfigProvider extends StatelessWidget {
  /// Element UI 配置注入，它非常简单，你可以根据需要自由组合它们，使用方式：
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
    // 设置全局文本样式
    el.globalTextStyle = TextStyle(
      color: context.elTheme.textColor,
      fontSize: el.typography.text,
      fontWeight: ElFont.normal,
    ).merge(el.config.textStyle);

    // 管理全局光标，Element UI 所有 hover 效果都依赖此组件
    return ElGlobalCursor(
      // 必须构建一个默认的 Material 组件，因为 Element UI 部分组件是直接基于 Material 的，
      // 如果你直接在页面中使用这些组件那么页面会报错，除非你手动添加 Material 组件。
      child: Material(
        textStyle: el.globalTextStyle,
        // 设置背景颜色
        child: AnimatedColoredBox(
          duration: el.config.bgDuration,
          color: context.elTheme.bgColor,
          // 设置 Element UI 样式滚动条
          child: ScrollConfiguration(
            behavior: const ElScrollBehavior(),
            // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等 api 时会报错
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

  /// 全局文本样式
  TextStyle globalTextStyle = const TextStyle();

  /// Element UI 颜色主题类型集合，因为枚举有点繁琐，所以类型使用字符串表示
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// 根节点导航key，使用全局 [context] 前你必须将此 key 配置到路由中
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
