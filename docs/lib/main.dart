import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void reassemble() {
    super.reassemble();
    // 热刷新时让路由配置立刻生效，不需要重启整个应用
    RouterUtil.isMobile.notify();
  }

  @override
  Widget build(BuildContext context) {
    currentThemeMode = ThemeMode.system;
    // 如果用户已经开启全局黑暗模式，那么不允许应用手动控制暗黑模式开关
    if (currentThemeMode == ThemeMode.system) {
      if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
        currentThemeMode = ThemeMode.dark;
      }
    }
    // 实时监听屏幕尺寸变化，如果 isMobile 发生变化，会重新构建路由
    RouterUtil.isMobile.value = context.sm;
    el.config = const ElConfigData(themeDuration: Duration.zero);
    ElFont.bold = FontWeight.w600;
    return ObsBuilder(builder: (context) {
      return MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: GlobalState.showSemanticsDebugger.value,
        showPerformanceOverlay: GlobalState.showPerformanceOverlay.value,
        themeAnimationDuration: el.config.themeDuration,
        themeAnimationCurve: el.config.themeCurve,
        theme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness: GlobalState.brightness,
        ),
        // theme: ThemeData(brightness: GlobalState.brightness),
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
