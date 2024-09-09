import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/responsive.dart';
import 'package:flutter_element_ui/src/extensions/theme.dart';
import 'package:flutter_element_ui/src/service.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'components/basic/text.dart';
import 'widgets/brightness.dart';
import 'styles/config_data.dart';
import 'styles/theme_data.dart';
import 'utils/font.dart';
import 'widgets/scroll_behavior.dart';

/// 为了尽可能减少上手成本，[ElApp] 只是一个简单的全局配置小部件，而不是基于 [WidgetsApp] 提供大量的配置参数，
/// Element UI 允许你自由地使用 [MaterialApp]、[CupertinoApp]、[WidgetsApp] 等任意顶级 App 构建应用。
class ElApp extends StatefulWidget {
  /// Element UI 全局配置小部件，使用方式：
  /// ```dart
  /// ElApp(
  ///   child: MaterialApp(
  ///     builder: ElApp.builder(),
  ///   ),
  /// );
  /// ```
  ///
  /// 1. [ElApp] 仅负责注入全局主题数据
  /// 2. [MaterialApp] 是官方默认构建应用的首选方式，你也可以使用其他 App 构建应用
  /// 3. [ElApp.builder] 则负责构建 Element UI 的默认文本主题、浮层小部件、滚动配置...
  const ElApp({
    super.key,
    required this.child,
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

  /// 在 [WidgetsApp]、[MaterialApp] 等顶级 App 下方构建 Element UI 小部件基础设施
  static Widget Function(BuildContext, Widget?) builder(
          [TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        assert(child != null, 'ElApp builder child 参数不能为空');

        final $data = AppProvider.of(context);
        // 创建默认遮罩小部件，否则使用依赖浮层元素 api 时会报错，例如：message、toast、loading
        Widget result = Overlay(initialEntries: [
          OverlayEntry(builder: (context) => child!),
        ]);

        // 在 Overlay 之上构建自定义小部件，可以避免 context 上下文bug
        if (builder != null) result = builder(context, result);

        return Material(
          animationDuration: $data.config.themeDuration,
          color: context.elTheme.bgColor,
          textStyle: $data.textStyle,
          child: ElAnimatedDefaultTextStyle(
            duration: $data.config.themeDuration,
            curve: $data.config.themeCurve,
            style: $data.textStyle,
            child: ScrollConfiguration(
              behavior: $data.behavior,
              child: result,
            ),
          ),
        );
      };

  @override
  State<ElApp> createState() => _ElAppState();
}

class _ElAppState extends State<ElApp> {
  Duration? _globalThemeDuration;
  Curve? _globalThemeCurve;
  Timer? _timer;

  @override
  void didUpdateWidget(covariant ElApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.brightness != oldWidget.brightness) {
      _changeTheme();
    }
  }

  /// 当亮度发生变化时，会设置全局主题变更持续时间和动画曲线，这样可以同步整体页面动画过渡效果
  void _changeTheme() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _globalThemeDuration = widget.config.themeDuration;
    _globalThemeCurve = widget.config.themeCurve;
    _timer = () {
      if (mounted) {
        setState(() {
          _globalThemeDuration = null;
          _globalThemeCurve = null;
          _timer = null;
        });
      }
    }.delay(max(500, widget.config.themeDuration.inMilliseconds));
  }

  @override
  Widget build(BuildContext context) {
    Brightness $brightness =
        widget.brightness ?? MediaQuery.platformBrightnessOf(context);

    // 构建默认的文本样式
    var $textStyle = ElFont.defaultTextStyle
        .copyWith(
            fontWeight: ElFont.normal,
            color: $brightness == Brightness.dark
                ? widget.darkTheme.textColor
                : widget.theme.textColor)
        .merge(widget.textStyle);

    // 如果未设置字体大小，则根据平台应用设置不同尺寸的字体，移动端使用 15px，桌面端使用 16px
    if ($textStyle.fontSize == null) {
      $textStyle = $textStyle.copyWith(fontSize: context.sm ? 15 : 16);
    }

    return BrightnessWidget(
      brightness: $brightness,
      child: AppProvider(
        widget.theme,
        widget.darkTheme,
        widget.config,
        $textStyle,
        _globalThemeDuration,
        _globalThemeCurve,
        widget.behavior,
        child: Builder(
            key: elAppKey,
            builder: (context) {
              return widget.child;
            }),
      ),
    );
  }
}

class AppProvider extends InheritedWidget {
  const AppProvider(
    this.theme,
    this.darkTheme,
    this.config,
    this.textStyle,
    this.globalThemeDuration,
    this.globalThemeCurve,
    this.behavior, {
    super.key,
    required super.child,
  });

  /// 亮色主题配置
  final ElThemeData theme;

  /// 暗色主题配置
  final ElThemeData darkTheme;

  /// 全局通用配置
  final ElConfigData config;

  /// 最终的全局文本样式，Element UI 预先提供一个默认的文本样式，然后合并颜色主题，最后合并用户自定义的文本样式
  final TextStyle textStyle;

  /// 当切换主题模式时，会临时设置全局默认的动画时间: [config.themeDuration]，这样可以保持动画过渡的一致性
  final Duration? globalThemeDuration;

  /// 全局动画曲线，同上
  final Curve? globalThemeCurve;

  /// 全局滚动行为
  final ScrollBehavior behavior;

  static AppProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppProvider>();
    assert(
        result != null,
        '当前上下文 context 没有找到 Element UI 全局主题配置，'
        '如果你已配置了 ElApp，请尝试使用 Builder 小部件转发 context。');
    return result!;
  }

  @override
  bool updateShouldNotify(AppProvider oldWidget) {
    return true;
  }
}
