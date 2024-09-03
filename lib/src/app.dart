import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/global.dart';
import 'package:luoyi_flutter_base/element_ui/components/duration.dart';

import 'services/theme.dart';
import 'utils/app_theme.dart';
import 'components/basic/scrollbar.dart';

/// Element UI 不再提供 [ElApp] 这样的复杂顶级小部件，而是提供一个简单的全局配置小部件，
/// 您可以使用任意 App 构建应用，例如：[MaterialApp]、[CupertinoApp]、[WidgetsApp]，
/// 如果你想构建支持全平台的应用，推荐直接使用 [MaterialApp]，Element UI 的主要定位只将其作为桌面端的补充。
class ElConfigProvider extends StatelessWidget {
  /// Element UI 全局配置注入，使用方式：
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
    this.builder,
    this.brightness = Brightness.light,
    this.behavior = const ElScrollBehavior(),
  });

  /// 顶级 App 提供的 builder 子组件
  final Widget child;

  /// 如果要插入自定义小部件，那么请使用 [builder] 而不是 [child]
  final TransitionBuilder? builder;

  /// 应用的主题模式，为 null 则表示跟随系统
  final Brightness? brightness;

  /// 自定义全局滚动行为，默认实现是 [ElScrollBehavior]，原生默认行为是 [ScrollBehavior]
  final ScrollBehavior behavior;

  @override
  Widget build(BuildContext context) {
    Brightness $brightness =
        brightness ?? MediaQuery.platformBrightnessOf(context);
    bool $isDark = $brightness == Brightness.dark;
    var $textStyle = ElThemeUtil.buildGlobalTextStyle($brightness);
    if ($textStyle.fontSize == null) {
      $textStyle = $textStyle.copyWith(fontSize: context.sm ? 15 : 16);
    }
    GlobalConfig.globalFontSize = $textStyle.fontSize!;

    // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等 api 时会报错
    Widget result = Overlay(initialEntries: [
      OverlayEntry(builder: (context) => child),
    ]);

    // 在 Overlay 之上构建自定义小部件，可以避免一些上下文bug
    if (builder != null) result = builder!(context, result);

    return ObsBuilder(
      builder: (context) {
        return ElThemeDuration(
          duration: globalThemeDuration.value,
          child: BrightnessWidget(
            brightness: $brightness,
            child: Material(
              animationDuration: el.themeDuration,
              color: $isDark ? el.darkTheme.bgColor : el.theme.bgColor,
              textStyle: $textStyle,
              child: ElAnimatedDefaultTextStyle(
                duration: el.themeDuration,
                style: $textStyle,
                child: ScrollConfiguration(
                  behavior: behavior,
                  child: result,
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
