import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:flutter_element_ui/src/styles/config_data.dart';
import 'package:flutter_element_ui/src/styles/theme_data.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'components/basic/scrollbar.dart';
import 'components/basic/text.dart';
import 'widgets/global_theme_duration.dart';

/// Element UI 不再提供 [ElApp] 顶级小部件，而是仅提供一个全局主题配置小部件，
/// 您可以使用任意 App 构建应用，例如：[MaterialApp]、[CupertinoApp]、[WidgetsApp]。
class ElTheme extends StatefulWidget {
  /// Element UI 全局主题配置小部件：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(
  ///     child: child!,
  ///   ),
  /// ),
  /// ```
  const ElTheme({
    super.key,
    required this.child,
    this.builder,
    this.brightness,
    this.theme = ElThemeData.theme,
    this.darkTheme = ElThemeData.darkTheme,
    this.config = ElConfigData.data,
    this.textStyle,
    this.behavior = const ElScrollBehavior(),
  });

  /// 接收 [WidgetsApp]、[MaterialApp] builder 提供的 child 参数，请不要在这里插入自定义组件，
  /// 你应当使用 [builder] 构建自定义子组件，它可以避免上下文 context 的问题。
  final Widget child;

  /// 使用方式等同于 [MaterialApp] 的 builder，它构建在 [Overlay] 小部件上方
  final TransitionBuilder? builder;

  /// 应用的主题模式，为 null 则表示跟随系统
  final Brightness? brightness;

  /// 亮色主题
  final ElThemeData theme;

  /// 暗色主题
  final ElThemeData darkTheme;

  /// 全局配置
  final ElConfigData config;

  /// 全局文本样式
  final TextStyle? textStyle;

  /// 自定义全局滚动行为，默认实现是 [ElScrollBehavior]，原生默认行为是 [ScrollBehavior]
  final ScrollBehavior behavior;

  /// 通过上下文 context 访问注入的全局主题配置
  static ({
    ElThemeData theme,
    ElThemeData darkTheme,
    ElConfigData config,
  }) of(BuildContext context) {
    final data = _ElThemeInheritedWidget.of(context);
    return (
      theme: data.theme,
      darkTheme: data.darkTheme,
      config: data.config,
    );
  }

  @override
  State<ElTheme> createState() => _ElThemeState();
}

class _ElThemeState extends State<ElTheme> {
  @override
  void didUpdateWidget(covariant ElTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Brightness $brightness =
        widget.brightness ?? MediaQuery.platformBrightnessOf(context);

    // 创建默认遮罩小部件，否则使用依赖浮层元素 api 时会报错，例如：message、toast、loading
    Widget result = Overlay(initialEntries: [
      OverlayEntry(builder: (context) => widget.child),
    ]);

    // 在 Overlay 之上构建自定义小部件，可以避免 context 上下文bug
    if (widget.builder != null) result = widget.builder!(context, result);

    return GlobalThemeStyle(
      child: _ElThemeInheritedWidget(
        widget.theme,
        widget.darkTheme,
        widget.config,
        child: BrightnessWidget(
          brightness: $brightness,
          child: Builder(builder: (context) {
            var $textStyle = GlobalConfig.defaultTextStyle
                .copyWith(
                  color: context.elTheme.textColor,
                )
                .merge(widget.textStyle);
            if ($textStyle.fontSize == null) {
              $textStyle = $textStyle.copyWith(fontSize: context.sm ? 15 : 16);
            }
            GlobalConfig.globalFontSize = $textStyle.fontSize!;
            return Material(
              animationDuration: widget.config.themeDuration,
              color: context.elTheme.bgColor,
              textStyle: $textStyle,
              child: ElAnimatedDefaultTextStyle(
                duration: widget.config.themeDuration,
                curve: widget.config.themeCurve,
                style: $textStyle,
                child: ScrollConfiguration(
                  behavior: widget.behavior,
                  child: result,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _ElThemeInheritedWidget extends InheritedWidget {
  const _ElThemeInheritedWidget(
    this.theme,
    this.darkTheme,
    this.config, {
    required super.child,
  });

  /// 亮色主题
  final ElThemeData theme;

  /// 暗色主题
  final ElThemeData darkTheme;

  /// 全局配置
  final ElConfigData config;

  static _ElThemeInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElThemeInheritedWidget>()!;

  @override
  bool updateShouldNotify(_ElThemeInheritedWidget oldWidget) {
    return true;
  }
}
