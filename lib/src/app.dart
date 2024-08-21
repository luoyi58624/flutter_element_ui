import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
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
    GlobalConfig.textStyle = el.config.textStyle;
    Widget result = BrightnessWidget(
      brightness: brightness ?? MediaQuery.of(context).platformBrightness,
      child: Builder(
        builder: (context) {
          return WidgetsApp.router(
            routerConfig: routerConfig,
            color: context.isDark ? el.theme.bgColor : el.darkTheme.bgColor,
            showSemanticsDebugger: showSemanticsDebugger,
            showPerformanceOverlay: showPerformanceOverlay,
            localizationsDelegates: const [
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            builder: (context, child) {
              return Material(
                color: context.elTheme.bgColor,
                textStyle: TextStyle(
                  fontWeight: ElFont.normal,
                  color: context.elTheme.textColor,
                ).merge(GlobalConfig.textStyle),
                child: ScrollConfiguration(
                  behavior: behavior,
                  child: builder!(context, child),
                  // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等 api 时会报错
                  // child: Builder(builder: (context) {
                  //   if (builder == null) {
                  //     return Overlay(initialEntries: [
                  //       OverlayEntry(builder: (context) {
                  //         return child!;
                  //       }),
                  //     ]);
                  //   } else {
                  //     return builder!(
                  //       context,
                  //       Overlay(initialEntries: [
                  //         OverlayEntry(builder: (context) => child!)
                  //       ]),
                  //     );
                  //   }
                  // }),
                ),
              );
            },
          );
        }
      ),
    );

    return result;
  }
}
