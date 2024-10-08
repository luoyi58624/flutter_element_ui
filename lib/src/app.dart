import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'components/basic/scrollbar.dart';
import 'global.dart';
import 'themes/config.dart';
import 'themes/theme.dart';
import 'utils/font.dart';

class ElApp extends StatefulWidget {
  /// Element UI 全局配置小部件
  /// ```dart
  /// ElApp(
  ///   child: MaterialApp(
  ///     builder: ElApp.builder(),
  ///   ),
  /// );
  /// ```
  const ElApp({
    super.key,
    required this.child,
    this.brightness,
    this.theme = ElThemeData.theme,
    this.darkTheme = ElThemeData.darkTheme,
    this.config = ElConfigData.data,
    this.textStyle,
    this.scrollBehavior = const ElScrollBehavior(),
  });

  /// 任意子组件
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
  final ScrollBehavior scrollBehavior;

  /// 通过上下文 context 访问注入的全局主题配置
  static ElAppData of(BuildContext context) =>
      _AppInheritedWidget.of(context).appData;

  /// 构建 Element UI 默认文本主题、默认的 [Overlay] 浮层、滚动配置...
  static Widget Function(BuildContext, Widget?) builder(
          [TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        assert(child != null, 'ElApp builder child 参数不能为空');

        final $data = _AppInheritedWidget.of(context);
        // 创建默认遮罩小部件，否则使用依赖浮层元素 api 时会报错，例如：message、toast、loading
        Widget result = Overlay(initialEntries: [
          OverlayEntry(
            builder: (context) => child!,
          ),
        ]);

        // 在 Overlay 之上构建自定义小部件，可以避免 context 上下文bug
        if (builder != null) result = builder(context, result);

        result = ElAnimatedDefaultTextStyle(
          duration: $data.appData.config.themeDuration,
          curve: $data.appData.config.themeCurve,
          style: $data.appData.textStyle,
          child: ScrollConfiguration(
            behavior: $data.scrollBehavior,
            child: result,
          ),
        );

        return Material(
          animationDuration: $data.appData.config.themeDuration,
          color: context.elTheme.colors.bg,
          textStyle: $data.appData.textStyle,
          child: result,
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
    _timer = setTimeout(() {
      if (mounted) {
        setState(() {
          _globalThemeDuration = null;
          _globalThemeCurve = null;
          _timer = null;
        });
      }
    }, max(500, widget.config.themeDuration.inMilliseconds));
  }

  bool get isDark => widget.brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    Brightness $brightness =
        widget.brightness ?? MediaQuery.platformBrightnessOf(context);

    // 构建默认的文本样式
    var $textStyle = ElFont.defaultTextStyle
        .copyWith(
            fontWeight: ElFont.normal,
            color: $brightness == Brightness.dark
                ? widget.darkTheme.colors.text
                : widget.theme.colors.text)
        .merge(widget.textStyle);

    // 如果未设置字体大小，则根据平台应用设置不同尺寸的字体，移动端使用 15px，桌面端使用 16px
    if ($textStyle.fontSize == null) {
      $textStyle = $textStyle.copyWith(fontSize: context.sm ? 15 : 16);
    }

    return _AppInheritedWidget(
      ElAppData(
        brightness: $brightness,
        theme: widget.theme,
        darkTheme: widget.darkTheme,
        config: widget.config,
        textStyle: $textStyle,
        globalThemeDuration: _globalThemeDuration,
        globalThemeCurve: _globalThemeCurve,
      ),
      widget.scrollBehavior,
      child: widget.child,
    );
  }
}

class _AppInheritedWidget extends InheritedWidget {
  const _AppInheritedWidget(
    this.appData,
    this.scrollBehavior, {
    required super.child,
  });

  final ElAppData appData;
  final ScrollBehavior scrollBehavior;

  static _AppInheritedWidget of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_AppInheritedWidget>();
    assert(
        result != null,
        '当前上下文 context 没有找到 Element UI 全局主题配置，'
        '如果你已配置了 ElApp，请尝试使用 Builder 小部件转发 context。');
    return result!;
  }

  @override
  bool updateShouldNotify(_AppInheritedWidget oldWidget) {
    return true;
  }
}

/// ElApp 注入的全局数据，你可以通过 [ElApp.of] 方法访问它们
class ElAppData {
  /// 当前主题模式
  final Brightness brightness;

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

  ElAppData({
    required this.brightness,
    required this.theme,
    required this.darkTheme,
    required this.config,
    required this.textStyle,
    this.globalThemeDuration,
    this.globalThemeCurve,
  });
}
