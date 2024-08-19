import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../services/context_menu.dart';
import '../../services/service.dart';
import '../../utils/font.dart';
import 'scrollbar.dart';

/// Element UI 没有提供顶级 App，而是提供一个全局配置注入小部件，这样做的目的是为了能无缝兼容其他设计语言的小部件，
/// 您可以使用任意 App 构建应用，例如：[MaterialApp]、[CupertinoApp]、[WidgetsApp]。
///
/// 虽然 Web 端的 Element UI 目标是桌面端组件库，但 Flutter 作为跨全平台框架，Flutter 版的 Element UI
/// 自然也要尽可能地支持全部平台，而官方提供的 Material 组件库设计十分完善，所以很多组件都是直接基于 Material 实现。
class ElConfigProvider extends StatelessWidget {
  /// Element UI 全局配置注入：
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
    this.brightness,
    this.behavior = const ElScrollBehavior(),
  });

  final Widget child;

  /// 应用平台亮度主题风格，如果为空，则跟随系统
  final Brightness? brightness;

  /// 自定义全局滚动行为，默认实现是 [ElScrollBehavior]，如果想要原生默认行为，请传递 [ScrollBehavior]
  final ScrollBehavior behavior;

  @override
  Widget build(BuildContext context) {
    GlobalConfig.textStyle = el.config.textStyle;
    return ContextMenuListenerWidget(
      // 无论用户使用 MaterialApp 还是 CupertinoApp，都通过此 Widget 判断当前是否是暗黑模式，
      // 此小部件没有对外暴露，请自行根据使用的主题进行封装，例如：Theme.of(context).brightness == Brightness.dark
      child: BrightnessWidget(
        brightness: brightness,
        // 注入响应式断点配置，此小部件没有对外暴露，请自行根据 el.responsive 封装
        child: ResponsiveWidget(
          data: el.responsive,
          child: Builder(builder: (context) {
            // 有些组件是直接基于 Material 进行二次封装的，所以需要构建一个默认的 Material 组件
            return Material(
              textStyle: TextStyle(
                fontWeight: ElFont.normal,
                color: context.elTheme.textColor,
              ).merge(el.config.textStyle),
              // 设置背景颜色
              child: AnimatedColoredBox(
                duration: el.config.colorDuration,
                color: context.elTheme.bgColor,
                // 设置全局滚动配置
                child: ScrollConfiguration(
                  behavior: behavior,
                  // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等 api 时会报错
                  child: Overlay(initialEntries: [
                    OverlayEntry(builder: (context) {
                      return child;
                    }),
                  ]),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
