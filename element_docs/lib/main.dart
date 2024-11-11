import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global.dart';
import 'utils/element_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    BrowserContextMenu.disableContextMenu();
  }
  // setPathUrlStrategy();
  // await initFont(
  //   windows: true,
  // );
  // if (PlatformUtil.isWindows) {
  //   ElFont.bold = FontWeight.w700;
  // }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  /// 当前应用的主题模式，默认跟随系统，如果当前平台启用了全局暗黑模式，那么此变量将强制为 dark，
  /// 这时将不允许手动切换暗黑、明亮主题。
  static late ThemeMode currentThemeMode;

  @override
  Widget build(BuildContext context) {
    GlobalState.globalFontSize = context.sm ? 15 : 16;
    MainApp.currentThemeMode = ThemeMode.system;
    if (currentThemeMode == ThemeMode.system) {
      if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
        MainApp.currentThemeMode = ThemeMode.dark;
      }
    }
    // 实时监听屏幕尺寸变化，如果 isMobile 发生变化，会重新构建路由
    RouterState.isMobile.value = context.sm;
    return ObsBuilder(builder: (context) {
      return ElApp(
        brightness: GlobalState.brightness,
        theme: buildElementTheme(),
        darkTheme: buildElementTheme(brightness: Brightness.dark),
        child: ObsBuilder(builder: (context) {
          return ElFps(
            enabled: GlobalState.fps.value,
            child: MaterialApp.router(
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              showSemanticsDebugger: GlobalState.showSemanticsDebugger.value,
              showPerformanceOverlay: GlobalState.showPerformanceOverlay.value,
              themeAnimationDuration: Duration.zero,
              theme: ElThemeUtil.buildMaterialTheme(
                context,
                brightness: GlobalState.brightness,
              ),
              darkTheme: ElThemeUtil.buildMaterialTheme(
                context,
                brightness: Brightness.dark,
              ),
              builder: ElApp.builder(
                builder: (context, child) => CupertinoTheme(
                  data: ElThemeUtil.buildCupertinoThemeData(
                    context,
                    brightness: GlobalState.brightness,
                  ),
                  child: child!,
                ),
                scrollBehavior: const ElScrollBehavior(showTrack: true),
              ),
            ),
          );
        }),
      );
    });
  }
}
