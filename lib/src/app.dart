import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'components/basic/text.dart';
import 'service.dart';
import 'services/theme.dart';
import 'utils/app_theme.dart';
import 'components/basic/scrollbar.dart';

/// Element UI 不再提供顶级 App，而是提供一个全局配置注入小部件，您可以使用任意 App 构建应用，
/// 例如：[MaterialApp]、[CupertinoApp]、[WidgetsApp]。
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
    this.themeMode = ThemeMode.system,
    this.behavior = const ElScrollBehavior(),
    this.builder,
  });

  final Widget child;

  /// 应用的主题模式，默认跟随系统，如果是跟随系统，你可以通过 [el.isDark] 手动控制主题模式，
  /// 你可以强制指定应用的主题：[ThemeMode.light]、[ThemeMode.dark]
  final ThemeMode themeMode;

  /// 自定义全局滚动行为，默认实现是 [ElScrollBehavior]，如果想要原生默认行为，请传递 [ScrollBehavior]
  final ScrollBehavior behavior;

  /// 在 Overlay 之上插入自定义小部件
  final TransitionBuilder? builder;

  @override
  Widget build(BuildContext context) {
    currentThemeMode = themeMode;
    return ObsBuilder(builder: (context) {
      if (themeMode == ThemeMode.system) {
        if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
          currentThemeMode = ThemeMode.dark;
        }
      }
      final $textStyle = ElThemeUtil.buildGlobalTextStyle(el.brightness);

      return BrightnessWidget(
        brightness: el.brightness,
        child: Material(
          animationDuration: el.config.themeDuration,
          color: context.elTheme.bgColor,
          textStyle: $textStyle,
          child: ElDefaultTextStyle(
            style: $textStyle,
            child: ScrollConfiguration(
              behavior: behavior,
              // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等 api 时会报错
              child: Builder(builder: (context) {
                Widget result = Overlay(initialEntries: [
                  OverlayEntry(builder: (context) {
                    return child;
                  }),
                ]);
                if (builder != null) {
                  result = builder!(context, result);
                }
                return result;
              }),
            ),
          ),
        ),
      );
    });
  }
}
