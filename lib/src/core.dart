import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';

import 'components/basic/scrollbar.dart';
import 'components/basic/typography.dart';
import 'components/others/responsive.dart';
import 'services/hover.dart';
import 'services/message/message.dart';
import 'services/toast.dart';
import 'styles/config.dart';
import 'styles/theme.dart';
import 'widgets/animation.dart';

class ElConfigProvider extends StatelessWidget {
  /// Element UI 全局配置注入，使用：
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
    ElThemeData $theme = context.isDark ? $el.darkTheme : $el.lightTheme;
    TextStyle $style = $el.config.textStyle.copyWith(color: $theme.textColor);
    return ElGlobalCursor(
      child: Material(
        child: AnimatedColoredBox(
          duration: $el.config.bgTransition.ms,
          color: context.elTheme.bgColor,
          child: ScrollConfiguration(
            behavior: const ElScrollBehavior(),
            child: ElTypographyInheritedWidget(
              data: ElTypographyData.data.merge($style),
              child: Overlay(initialEntries: [
                OverlayEntry(builder: (context) {
                  return child;
                }),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

/// Element UI 全局服务对象
final $el = _ElService();

// ============================================================================
// 之前使用 InheritedWidget 去注入全局配置信息，使用一段时间后发现这种行为就是多此一举，
// InheritedWidget 更适合为局部提供默认状态，通过当前上下文 context 访问最近的配置信息，
// 可以完美地实现数据隔离，不会引起冲突，但这种特性对于全局数据来讲将失去意义，没有哪个应用
// 会创建多种相互隔离的主题模式。
//
// 在 Flutter 中，数据和 UI 是完全解耦的，无论你将数据放在哪里，当数据发生变化后只需调用
// Api 通知页面刷新即可，抛弃 InheritedWidget 管理数据，你可以在任意地方去使用它，
// 而无需通过 context 上下文去查找。
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

  /// 文本排版配置
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
