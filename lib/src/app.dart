import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'components/basic/text.dart';
import 'service.dart';
import 'utils/app_theme.dart';
import 'components/basic/scrollbar.dart';

/// Element UI 不再提供 [ElApp] 这样的复杂顶级小部件，而是提供一个简单的全局配置小部件，
/// 您可以使用任意 App 构建应用，例如：[MaterialApp]、[CupertinoApp]、[WidgetsApp]。
class ElConfigProvider extends StatelessWidget {
  /// Element UI 全局配置注入：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElConfigProvider(
  ///     child: child!,
  ///   ),
  /// ),
  /// ```
  ///
  /// 对于全局主题、全局配置请直接通过全局变量 [el] 修改即可，例如：
  /// ```dart
  /// el.theme = ElThemeData();
  /// el.darkTheme = ElThemeData.dark();
  /// el.config = ElConfigData();
  /// ```
  const ElConfigProvider({
    super.key,
    required this.child,
    this.brightness = Brightness.light,
    this.behavior = const ElScrollBehavior(),
  });

  final Widget child;

  /// 应用的主题模式，默认跟随系统
  final Brightness? brightness;

  /// 自定义全局滚动行为，默认实现是 [ElScrollBehavior]，如果想要原生默认行为，请传递 [ScrollBehavior]
  final ScrollBehavior behavior;

  @override
  Widget build(BuildContext context) {
    Brightness $brightness =
        brightness ?? MediaQuery.platformBrightnessOf(context);
    final $textStyle = ElThemeUtil.buildGlobalTextStyle($brightness);
    el.globalFontSize = $textStyle.fontSize ?? (context.sm ? 15 : 16);
    return BrightnessWidget(
      brightness: $brightness,
      child: Material(
        animationDuration: el.config.themeDuration,
        color: context.elTheme.bgColor,
        textStyle: $textStyle,
        child: ElDefaultTextStyle(
          style: $textStyle,
          child: ScrollConfiguration(
            behavior: behavior,
            // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等 api 时会报错
            child: Overlay(initialEntries: [
              OverlayEntry(builder: (context) => child),
            ]),
          ),
        ),
      ),
    );
  }
}
