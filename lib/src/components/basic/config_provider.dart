import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../services/service.dart';
import 'scrollbar.dart';

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
    // 初始化全局文本样式
    el.initGlobalTextStyle(context);
    // 注入平台亮度，它的作用很简单，无论用户使用 MaterialApp 还是 CupertinoApp，
    // 都通过此 Widget 判断当前是否是暗黑模式
    return BrightnessWidget(
      brightness: brightness,
      // 注入响应式断点配置，此 Widget 提供了 context 扩展函数，但只应用于 Element 内部，
      // 如有需要请自行通过 el.responsive 封装一套
      child: ResponsiveWidget(
        data: el.responsive,
        // 有些组件是直接基于 Material 进行二次封装的，所以需要构建一个默认的 Material 组件，防止报错
        child: Material(
          textStyle: el.globalTextStyle,
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
        ),
      ),
    );
  }
}
