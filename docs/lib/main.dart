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
    // 如果用户已经开启全局黑暗模式，那么不允许应用手动控制暗黑模式开关
    if (MainApp.currentThemeMode == ThemeMode.system) {
      if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
        MainApp.currentThemeMode = ThemeMode.dark;
      }
    }
    // 实时监听屏幕尺寸变化，如果 isMobile 发生变化，会重新构建路由
    RouterUtil.isMobile.value = context.sm;

    // 不应用主题切换动画
    el.themeDuration = 0.ms;
    return ObsBuilder(builder: (context) {
      return MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: GlobalState.showSemanticsDebugger.value,
        showPerformanceOverlay: GlobalState.showPerformanceOverlay.value,
        themeAnimationDuration: el.themeDuration,
        theme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness: GlobalState.brightness,
        ),
        darkTheme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness: Brightness.dark,
        ),
        builder: (context, child) => CupertinoTheme(
          data: ElThemeUtil.buildCupertinoThemeData(
            context,
            brightness: GlobalState.brightness,
          ),
          child: ElConfigProvider(
            brightness: GlobalState.brightness,
            child: child!,
          ),
        ),
      );
    });
  }
}