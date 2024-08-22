import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'components/basic/text.dart';
import 'service.dart';
import 'services/theme.dart';
import 'utils/font.dart';
import 'components/basic/scrollbar.dart';

/// Element UI 不再提供顶级 App，而是提供一个全局配置注入小部件，
/// 因为 [MaterialApp] 设计得十分完善，没有必要造重复轮子。
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

  /// 应用的主题模式，默认跟随系统，你可以强制指定应用的主题：[ThemeMode.light]、[ThemeMode.dark]
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
      return BrightnessWidget(
        brightness: el.brightness,
        child: Builder(builder: (context) {
          globalTextStyle = globalTextStyle
              .copyWith(
                fontWeight: ElFont.normal,
                color: context.elTheme.textColor,
              )
              .merge(el.config.textStyle);
          return Material(
            animationDuration: el.config.themeDuration,
            color: context.elTheme.bgColor,
            textStyle: globalTextStyle,
            child: ElDefaultTextStyle(
              style: globalTextStyle,
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
          );
        }),
      );
    });
  }
}
