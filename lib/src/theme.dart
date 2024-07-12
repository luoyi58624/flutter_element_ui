import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'service.dart';
import 'styles/theme.dart';

part 'theme/data.dart';

part 'theme/theme_widget.dart';

part 'theme/extension.dart';

/// Element UI 主题小部件，在设计上即使你不使用它也能使用所有的小部件，同时，为了保证兼容性，
/// 我没有提供 ElApp 这样的顶级小部件，相反，你可以使用任意顶级小部件去构建应用程序：
/// ```dart
/// ElTheme(
///   child: MaterialApp(
///     home: HomePage(),
///   ),
/// ),
/// ```
///
/// 注意：使用 [MaterialApp] 有一个很常见的文本错误，字体下方有黄色的双下划线，
/// 这是错误是官方要求你必须在 [Material] 小部件中使用文本组件，解决方案很简单：
/// ```
/// MaterialApp(
///   builder: (context, child) => Material(
///     child: child!,
///   ),
/// ),
/// ```
///
/// 提示：你也可以直接使用 [WidgetsApp] 去构建应用，所有顶级 App 都是基于它的封装。
class ElTheme extends StatelessWidget {
  /// Element UI 主题系统小部件（可选）
  ElTheme({
    super.key,
    required this.child,
    this.data,
    this.brightness,
    this.navigatorKey,
  }) {
    elRootNavigatorKey = navigatorKey;
  }

  final Widget child;

  /// 自定义全局主题数据
  final ElThemeData? data;

  /// 设置平台明亮、暗色主题模式，如果为空则跟随系统
  final Brightness? brightness;

  /// 根节点导航key，如果你用到一些依赖路由的Api，请设置它
  final GlobalKey<NavigatorState>? navigatorKey;

  /// 通过上下文获取全局主题
  static ElThemeData of(BuildContext context) =>
      _ElThemeWidget.maybeOf(context)?.data ?? $el.defaultThemeData;

  @override
  Widget build(BuildContext context) {
    final $data = data ?? $el.defaultThemeData;
    return _ElResponsive(
      data: $data.responsive,
      child: _ElBrightness(
        brightness: brightness,
        child: _ElGlobalCursor(
          child: _ElThemeWidget(
            elTheme: this,
            child: child,
          ),
        ),
      ),
    );
  }
}
