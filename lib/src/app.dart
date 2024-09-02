import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/global.dart';

import 'utils/app_theme.dart';
import 'components/basic/scrollbar.dart';

/// Element UI 不再提供 [ElApp] 这样的复杂顶级小部件，而是提供一个简单的全局配置小部件，
/// 您可以使用任意 App 构建应用，例如：[MaterialApp]、[CupertinoApp]、[WidgetsApp]，
/// 如果你想构建支持全平台的应用，推荐直接使用 [MaterialApp]，对于 Element UI 的定位，
/// 我只将其作为桌面端的补充，并尽可能保证组件在所有平台的兼容性。
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
  /// el.theme = ElThemeData(primary: Colors.blue);
  /// el.darkTheme = ElThemeData.dark(primary: Colors.green);
  /// el.config = ElConfigData();
  /// ```
  ///
  /// 要访问主题，请使用 context.elTheme 扩展方法获取自适应颜色主题变量，它会自动适配 light、dark 主题模式
  const ElConfigProvider({
    super.key,
    required this.child,
    this.builder,
    this.brightness = Brightness.light,
    this.behavior = const ElScrollBehavior(),
  });

  /// MaterialApp builder 提供的子组件
  final Widget child;

  /// 当你想注入其他主题小部件时不要直接应用在 [child] 上，当切换主题时它不会生效，
  /// 你应当使用 [builder] 构建它，示例：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElConfigProvider(
  ///     child: child!,
  ///     builder: (context, child) => CupertinoTheme(
  ///       data: CupertinoThemeData(brightness: Theme.of(context).brightness),
  ///       child: child!,
  ///     ),
  ///   ),
  /// ),
  /// ```
  ///
  /// 这跟内部构建的 [Overlay] 小部件工作机制有关，使用 [builder] 会在 [Overlay] 之上插入你的自定义小部件。
  final TransitionBuilder? builder;

  /// 应用的主题模式，为 null 则表示跟随系统
  final Brightness? brightness;

  /// 自定义全局滚动行为，默认实现是 [ElScrollBehavior]，如果想要原生默认行为，请传递 [ScrollBehavior]
  final ScrollBehavior behavior;

  @override
  Widget build(BuildContext context) {
    Brightness $brightness =
        brightness ?? MediaQuery.platformBrightnessOf(context);
    bool $isDark = $brightness == Brightness.dark;
    var $textStyle = ElThemeUtil.buildGlobalTextStyle($brightness);
    if ($textStyle.fontSize == null) {
      $textStyle = $textStyle.copyWith(fontSize: context.sm ? 15 : 16);
    }
    GlobalConfig.globalFontSize = $textStyle.fontSize!;
    Widget result = ElAnimatedDefaultTextStyle(
      duration: el.themeDuration,
      style: $textStyle,
      child: ScrollConfiguration(
        behavior: behavior,
        // 创建默认遮罩小部件，否则当使用全局 context 插入弹窗、消息等 api 时会报错
        child: Overlay(initialEntries: [
          OverlayEntry(builder: (context) => child),
        ]),
      ),
    );
    if (builder != null) result = builder!(context, result);
    // 平台亮度小部件，Element UI 使用它统一访问当前是否是暗黑模式，但它不对外提供
    return BrightnessWidget(
      brightness: $brightness,
      // 构建全局默认的 Material 组件，主要解决黄色双下划线文字错误问题
      child: Material(
        animationDuration: el.themeDuration,
        color: $isDark ? el.darkTheme.bgColor : el.theme.bgColor,
        textStyle: $textStyle,
        child: result,
      ),
    );
  }
}
