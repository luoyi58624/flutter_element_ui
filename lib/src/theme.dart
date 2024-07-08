import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/components/basic/brightness.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'components/basic/icon.dart';
import 'components/basic/responsive.dart';
import 'components/basic/scrollbar.dart';
import 'service.dart';
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
  final ElResponsiveData responsive;

  ElThemeData({
    ElColorThemeData? theme,
    ElColorThemeData? darkTheme,
    ElConfigData? config,
    this.responsive = const ElResponsiveData(),
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

  /// 定义平台应用的主题模式，如果为空则跟随系统，建议将该值和你的顶级 App 组件进行绑定，示例：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(
  ///      brightness: Theme.of(context).brightness,
  ///      child: child!,
  ///   ),
  /// );
  /// ```
  final Brightness? brightness;

  /// 自定义全局滚动行为，默认使用[ElScrollBehavior]
  /// * 在桌面端，滚动容器会自动应用[ElScrollbar]
  /// * 在移动端，滚动容器会自动应用[Scrollbar]
  ///
  /// 注意：如果你在某个滚动容器上应用自定义滚动条，你必须嵌套[ScrollConfiguration]移除默认的滚动条，
  /// 否则 Flutter 将绘制两个重叠的滚动条，这种行为是正常现象，新建空白项目嵌套自定义滚动条在桌面端同样存在问题，
  /// Flutter桌面端默认使用[Scrollbar]，请使用[CupertinoScrollbar]进行测试。
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
    return ElResponsive(
      data: $data.responsive,
      child: ElBrightness(
        brightness: brightness,
        child: Builder(builder: (context) {
          ElColorThemeData $theme =
              context.isDark ? $data.darkTheme : $data.theme;
          TextStyle $style = (textStyle ?? const TextStyle()).copyWith(
              fontSize: $data.config.fonSize, color: $theme.textColor);
          return Material(
            surfaceTintColor: Colors.transparent,
            color: $theme.bgColor,
            textStyle: $style,
            child: ElIconTheme(
              size: $data.config.iconSize,
              color: $theme.iconColor,
              child: _ElTheme(
                elTheme: this,
                child: ScrollConfiguration(
                  behavior: behavior ?? const ElScrollBehavior(),
                  child: _ElGlobalHoverWidget(
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

class _ElGlobalHoverWidget extends StatelessWidget {
  const _ElGlobalHoverWidget({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return MouseRegion(
        cursor: $el.cursor.value,
        child: child,
      );
    });
  }
}
