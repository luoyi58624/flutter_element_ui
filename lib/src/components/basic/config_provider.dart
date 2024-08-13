import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../services/context_menu.dart';
import '../../services/service.dart';
import '../../utils/font.dart';
import 'scrollbar.dart';

/// Element UI 没有提供顶级 App，而是提供全局配置注入小部件，这是为了
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

  /// 自定义全局滚动行为，默认实现是 [ScrollBehavior]
  final ScrollBehavior behavior;

  @override
  Widget build(BuildContext context) {
    return ContextMenuListenerWidget(
      // 无论用户使用 MaterialApp 还是 CupertinoApp，都通过此 Widget 判断当前是否是暗黑模式
      child: BrightnessWidget(
        brightness: brightness,
        // 注入响应式断点配置
        child: ResponsiveWidget(
          data: el.responsive,
          child: Builder(builder: (context) {
            // 有些组件是直接基于 Material 进行二次封装的，所以需要构建一个默认的 Material 组件，防止报错
            return Material(
              textStyle: TextStyle(
                fontSize: el.typography.text,
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
