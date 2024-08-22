import 'package:docs/global.dart';
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
    // 如果 Obs 的值相同，则不会触发刷新，所以需要在热刷新中通知响应式变量重建路由，
    // 这样当更新了路由配置后就能立刻生效，不需要重启整个应用
    RouterUtil.isMobile.notify();
  }

  @override
  Widget build(BuildContext context) {
    // 实时监听屏幕尺寸变化，如果 isMobile 发生变化，会自动构建响应式路由
    RouterUtil.isMobile.value = context.sm;
    el.theme = ElThemeData(bgColor: Colors.white);
    el.config = const ElConfigData(themeDuration: Duration.zero);
    return ObsBuilder(builder: (context) {
      return MaterialApp.router(
        routerConfig: router,
        themeAnimationDuration: el.config.themeDuration,
        themeAnimationCurve: el.config.themeCurve,
        theme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness: el.brightness,
        ),
        darkTheme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness: Brightness.dark,
        ),
        builder: (context, child) => ElConfigProvider(
          child: child!,
        ),
      );
    });
  }
}
