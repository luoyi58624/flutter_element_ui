import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/common.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'components/basic/icon.dart';
import 'components/basic/scrollbar.dart';
import 'styles/theme.dart';

/// Element UI 颜色主题类型集合
const List<String> elThemeTypes = [
  'primary',
  'success',
  'info',
  'warning',
  'error'
];

/// Element UI 全局主题
class ElThemeData {
  late final ElColorThemeData theme;
  late final ElColorThemeData darkTheme;
  late final ElConfigData config;

  ElThemeData({
    ElColorThemeData? theme,
    ElColorThemeData? darkTheme,
    ElConfigData? config,
  }) {
    this.theme = theme ?? ElColorThemeData.theme;
    this.darkTheme = darkTheme ?? ElColorThemeData.darkTheme;
    this.config = config ?? ElConfigData.config;
  }
}

class ElTheme extends StatelessWidget {
  /// Element UI 全局主题小部件，这是可选的，但如果你要用到
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(
  ///     child: child!,
  ///   ),
  /// );
  /// ```
  ElTheme({
    super.key,
    required this.child,
    this.data,
    this.textStyle,
    this.brightness,
    this.behavior,
    this.navigatorKey,
  }) {
    elRootNavigatorKey = navigatorKey;
  }

  final Widget child;

  /// 主题数据，默认[defaultThemeData]
  final ElThemeData? data;

  /// 全局文字默认样式，[ElTheme]会创建一个全新的[DefaultTextStyle]，但不会继承父级的默认样式，
  /// 因为[MaterialApp]存在一个自以为是的错误文本样式[_errorTextStyle]，具体行为就是如果你
  /// 没有在[Material]组件下使用文字小部件，那么文字将变成黄色、双下划线样式，这种行为是Flutter官方刻意为之，
  /// 所以我决定在所有设计系统的根节点下创建一个新的默认文本，而不是继承父级，否则对于新手而言，可能会造成一脸懵逼。
  final TextStyle? textStyle;

  /// 定义平台应用的主题模式，如果为空则跟随系统，建议将该值和你的顶级 App 组件绑定，示例：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(
  ///      brightness: Theme.of(context).brightness,
  ///      child: child!,
  ///   ),
  /// );
  /// ```
  final Brightness? brightness;

  /// 自定义全局滚动行为
  final ScrollBehavior? behavior;

  /// 根节点导航key，如果你用到一些依赖路由的Api，请设置它，因为 Element UI 内部需要通过它实现无 context 跳转
  final GlobalKey<NavigatorState>? navigatorKey;

  static ElThemeData defaultThemeData = ElThemeData(
    theme: ElColorThemeData.theme,
    darkTheme: ElColorThemeData.darkTheme,
    config: ElConfigData.config,
  );

  /// 通过上下文获取全局主题
  static ElThemeData of(BuildContext context) =>
      _ElTheme.maybeOf(context)?.data ?? defaultThemeData;

  @override
  Widget build(BuildContext context) {
    final $data = data ?? defaultThemeData;
    return ResponsiveWidget(
      data: const ResponsiveData(),
      child: BrightnessWidget(
        brightness: brightness,
        child: Builder(builder: (context) {
          TextStyle $style = (textStyle ?? const TextStyle()).copyWith(
              color: context.isDark
                  ? $data.darkTheme.textColor
                  : $data.theme.textColor);
          return DefaultTextStyle(
            style: $style,
            child: ElIconTheme(
              size: 18,
              color: context.isDark
                  ? $data.darkTheme.iconColor
                  : $data.theme.iconColor,
              child: TypographyInheritedWidget(
                model: TypographyModel(
                  titleColor: $data.theme.titleColor,
                  titleDarkColor: $data.darkTheme.titleColor,
                  textColor: $data.theme.textColor,
                  textDarkColor: $data.darkTheme.textColor,
                ),
                child: _ElTheme(
                  elTheme: this,
                  child: ScrollConfiguration(
                    behavior: behavior ?? const ElScrollBehavior(),
                    child: GlobalHoverWidget(
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// 全局主题注入实例
class _ElTheme extends InheritedWidget {
  const _ElTheme({required super.child, required this.elTheme});

  final ElTheme elTheme;

  static ElTheme? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElTheme>()?.elTheme;

  @override
  bool updateShouldNotify(_ElTheme oldWidget) => true;
}
