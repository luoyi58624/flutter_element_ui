import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'components/basic/icon.dart';
import 'components/basic/scrollbar.dart';
import 'service.dart';
import 'styles/theme.dart';

part 'theme/theme_widget.dart';

part 'theme/extension.dart';

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
  late final ElBrightnessData theme;
  late final ElBrightnessData darkTheme;
  late final ElConfigData config;
  final ElResponsiveData responsive;

  ElThemeData({
    ElBrightnessData? theme,
    ElBrightnessData? darkTheme,
    ElConfigData? config,
    this.responsive = const ElResponsiveData(),
  }) {
    this.theme = theme ?? ElBrightnessData.lightTheme;
    this.darkTheme = darkTheme ?? ElBrightnessData.darkTheme;
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

  /// 全局文字默认样式
  final TextStyle? textStyle;

  /// 定义平台应用的主题模式，如果为空则跟随系统，如果你设置了手动切换暗黑模式，
  /// 那么请将该值和你的 App 组件进行绑定，示例：
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
  /// 否则 Flutter 将绘制两个重叠的滚动条。
  final ScrollBehavior? behavior;

  /// 根节点导航key，如果你用到一些依赖路由的Api，请设置它
  final GlobalKey<NavigatorState>? navigatorKey;

  static final ElThemeData _defaultThemeData = ElThemeData();

  /// 通过上下文获取全局主题
  static ElThemeData of(BuildContext context) =>
      _ElThemeWidget.maybeOf(context)?.data ?? _defaultThemeData;

  @override
  Widget build(BuildContext context) {
    final $data = data ?? _defaultThemeData;
    return _ElResponsiveWidget(
      data: $data.responsive,
      child: _ElBrightness(
        brightness: brightness,
        child: Builder(builder: (context) {
          ElBrightnessData $theme =
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
              child: _ElThemeWidget(
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
