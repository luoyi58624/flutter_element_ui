import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  /// 当前应用的主题模式，默认跟随系统，如果当前平台启用了全局暗黑模式，那么此变量将强制为 dark，
  /// 这时将不允许手动切换暗黑、明亮主题。
  static late ThemeMode currentThemeMode;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    MainApp.currentThemeMode = ThemeMode.system;
    if (MainApp.currentThemeMode == ThemeMode.system) {
      if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
        MainApp.currentThemeMode = ThemeMode.dark;
      }
    }
    // 实时监听屏幕尺寸变化，如果 isMobile 发生变化，会重新构建路由
    RouterUtil.isMobile.value = context.sm;
    final themeDuration = 0.ms;
    return ObsBuilder(builder: (context) {
      return ElApp(
        brightness: GlobalState.brightness,
        config: ElConfigData(
          themeDuration: themeDuration,
        ),
        theme: ElThemeData(
          collapseStyle: ElCollapseStyle(
            duration: 300.ms,
          ),
        ),
        child: ObsBuilder(builder: (context) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            showSemanticsDebugger: GlobalState.showSemanticsDebugger.value,
            showPerformanceOverlay: GlobalState.showPerformanceOverlay.value,
            themeAnimationDuration: themeDuration,
            theme: ElThemeUtil.buildMaterialTheme(
              context,
              brightness: GlobalState.brightness,
            ),
            // darkTheme: ElThemeUtil.buildMaterialTheme(
            //   context,
            //   brightness: Brightness.dark,
            // ),
            builder: ElApp.builder(
              (context, child) => CupertinoTheme(
                data: ElThemeUtil.buildCupertinoThemeData(
                  context,
                  brightness: GlobalState.brightness,
                ),
                child: child!,
              ),
            ),
          );
        }),
      );
    });
  }
}
