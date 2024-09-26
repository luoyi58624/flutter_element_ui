import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'private.dart';

part 'state.dart';

part 'styles/color.dart';

part 'styles/config.dart';

part 'styles/theme.dart';

part '../../../generates/components/basic/app/index.g.dart';

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
  static AppData of(BuildContext context) =>
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
  State<ElApp> createState() => ElAppState();
}

class _AppInheritedWidget extends InheritedWidget {
  const _AppInheritedWidget(
    this.appData,
    this.scrollBehavior, {
    required super.child,
  });

  final AppData appData;
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
