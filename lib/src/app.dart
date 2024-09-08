import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'components/basic/scrollbar.dart';
import 'components/basic/text.dart';
import 'styles/config_data.dart';
import 'styles/theme_data.dart';
import 'utils/font.dart';

/// 为了尽可能减少与其他主题系统的兼容性问题，[ElApp] 被设计为一个全局配置小部件，
/// 你必须使用 [MaterialApp]、[CupertinoApp]、[WidgetsApp] 等任意顶级小部件构建应用。
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
  /// 代码结构解析：
  /// 1. 首先使用 [ElApp] 注入全局主题数据；
  /// 2. 然后使用 [MaterialApp] 构建应用基础设施；
  /// 3. 最后使用 [ElApp.builder] 构建默认的文本主题、浮层小部件、滚动配置...
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

  /// 通过上下文 context 访问注入的全局主题配置
  static ElThemeModel of(BuildContext context) =>
      _AppInheritedWidget.of(context).themeModel;

  /// 在 [WidgetsApp]、[MaterialApp] 等顶级 App 下方构建 Element UI 小部件基础设施，
  /// 下面逻辑之所以不放在 build 中是为了防止被覆盖。
  /// ```dart
  /// MaterialApp(
  ///   builder: ElApp.builder(),
  /// );
  ///
  /// // 插入自定义小部件
  /// MaterialApp(
  ///   builder: ElApp.builder(
  ///     (context, child) => SizeBox(child: child!),
  ///   ),
  /// );
  /// ```
  static Widget Function(BuildContext, Widget?) builder(
          [TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        assert(child != null, 'ElTheme builder 子组件不能为空');

        final $data = _AppInheritedWidget.of(context);
        // 创建默认遮罩小部件，否则使用依赖浮层元素 api 时会报错，例如：message、toast、loading
        Widget result = Overlay(initialEntries: [
          OverlayEntry(builder: (context) => child!),
        ]);

        // 在 Overlay 之上构建自定义小部件，可以避免 context 上下文bug
        if (builder != null) result = builder(context, result);

        return Material(
          animationDuration: $data.themeModel.config.themeDuration,
          color: context.elTheme.bgColor,
          textStyle: $data.themeModel.textStyle,
          child: ElAnimatedDefaultTextStyle(
            duration: $data.themeModel.config.themeDuration,
            curve: $data.themeModel.config.themeCurve,
            style: $data.themeModel.textStyle,
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
      changeTheme();
    }
  }

  void changeTheme() {
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
    var $textStyle = GlobalConfig.defaultTextStyle
        .copyWith(
            fontWeight: ElFont.normal,
            color: $brightness == Brightness.dark
                ? widget.darkTheme.textColor
                : widget.theme.textColor)
        .merge(widget.textStyle);
    if ($textStyle.fontSize == null) {
      $textStyle = $textStyle.copyWith(fontSize: context.sm ? 15 : 16);
    }
    GlobalConfig.globalFontSize = $textStyle.fontSize!;

    return BrightnessWidget(
      brightness: $brightness,
      child: _AppInheritedWidget(
        ElThemeModel(
          theme: widget.theme,
          darkTheme: widget.darkTheme,
          config: widget.config,
          textStyle: $textStyle,
          globalThemeDuration: _globalThemeDuration,
          globalthemeCurve: _globalThemeCurve,
        ),
        widget.behavior,
        child: Builder(builder: (context) {
          return widget.child;
        }),
      ),
    );
  }
}

class ElThemeModel {
  final ElThemeData theme;
  final ElThemeData darkTheme;
  final ElConfigData config;
  final TextStyle textStyle;

  /// 当切换主题模式时，临时设置全局默认的动画时间: [config.themeDuration]，
  /// 这样可以保持动画过渡的一致性。
  final Duration? globalThemeDuration;
  final Curve? globalthemeCurve;

  ElThemeModel({
    required this.theme,
    required this.darkTheme,
    required this.config,
    required this.textStyle,
    this.globalThemeDuration,
    this.globalthemeCurve,
  });
}

class _AppInheritedWidget extends InheritedWidget {
  const _AppInheritedWidget(
    this.themeModel,
    this.behavior, {
    required super.child,
  });

  final ElThemeModel themeModel;
  final ScrollBehavior behavior;

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
