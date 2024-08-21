import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'service.dart';
import 'utils/font.dart';
import 'components/basic/scrollbar.dart';

class ElApp extends StatelessWidget {
  /// Element UI 作为桌面端组件库，你必须使用声明式路由创建应用，传统的命令式导航在桌面端存在很多缺陷
  const ElApp.router({
    super.key,
    required this.routerConfig,
    this.brightness,
    this.behavior = const ElScrollBehavior(),
    this.showSemanticsDebugger = false,
    this.showPerformanceOverlay = false,
    this.debugShowCheckedModeBanner = true,
    this.builder,
  });

  /// 声明式路由配置，推荐使用官方提供的 [go_router] 路由库
  final RouterConfig<Object> routerConfig;

  /// 应用平台亮度主题风格，如果为空，则跟随系统
  final Brightness? brightness;

  /// 自定义全局滚动行为，默认实现是 [ElScrollBehavior]，如果想要原生默认行为，请传递 [ScrollBehavior]
  final ScrollBehavior behavior;

  /// 是否显示语义调试
  final bool showSemanticsDebugger;

  /// 是否显示性能浮层
  final bool showPerformanceOverlay;

  /// 是否显示 debug 调试标志
  final bool debugShowCheckedModeBanner;

  /// App 子组件构建器
  final TransitionBuilder? builder;

  @override
  Widget build(BuildContext context) {
    // 设置应用全局主题模式
    GlobalConfig.brightness =
        brightness ?? MediaQuery.of(context).platformBrightness;
    GlobalConfig.textStyle = el.config.textStyle;
    Widget result = WidgetsApp.router(
      routerConfig: routerConfig,
      color: el.isDark ? el.lightTheme.bgColor : el.darkTheme.bgColor,
      showSemanticsDebugger:showSemanticsDebugger ,
      showPerformanceOverlay: showPerformanceOverlay,
      builder: (context, child) {
        return Material(
          color: el.theme.bgColor,
          textStyle: TextStyle(
            fontWeight: ElFont.normal,
            color: el.theme.textColor,
          ).merge(el.config.textStyle),
          child: ScrollConfiguration(
            behavior: behavior,
            // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等 api 时会报错
            child: Overlay(initialEntries: [
              OverlayEntry(builder: (context) {
                return builder != null ? builder!(context, child!) : child!;
              }),
            ]),
          ),
        );
      },
    );

    return result;
  }
}
