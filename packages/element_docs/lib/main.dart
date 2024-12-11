import 'package:element_docs/shortcuts/global_shortcut.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'demo.dart';
import 'global.dart';
import 'utils/element_size_preset.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await El.init();
  // setPathUrlStrategy();
  // await initFont(
  //   windows: true,
  // );
  // if (PlatformUtil.isWindows) {
  //   ElFont.bold = FontWeight.w700;
  // }
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
  void initState() {
    super.initState();
    nextTick(() {
      RouterState.currentPath.value =
          router.routerDelegate.state?.fullPath ?? '/';
      router.routerDelegate.addListener(() {
        try {
          RouterState.currentPath.value =
              router.routerDelegate.state?.fullPath ?? '/';
        } catch (e) {
          return;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    router.routerDelegate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MainApp.currentThemeMode = ThemeMode.system;
    if (MainApp.currentThemeMode == ThemeMode.system) {
      if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
        MainApp.currentThemeMode = ThemeMode.dark;
      }
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyQ, shift: true): () {
          GlobalState.showPerformanceOverlay.value =
              !GlobalState.showPerformanceOverlay.value;
        },
        const SingleActivator(LogicalKeyboardKey.keyW, shift: true): () {
          el.message.success('hello');
        }
      },
      child: ObsBuilder(
        binding: [GlobalState.enableResampling],
        builder: (context) {
          return ElApp(
            brightness: GlobalState.brightness,
            theme: ThemeUtil.buildElementTheme(),
            darkTheme: ThemeUtil.buildElementTheme(brightness: Brightness.dark),
            config: const ElConfigData(elSize: ElSize.medium),
            sizePreset: elSizePreset,
            child: ObsBuilder(builder: (context) {
              isMobileRoute.value = context.sm;
              GlobalState.globalFontSize = context.sm ? 15 : 16;
              return ElFps(
                enabled: GlobalState.fps.value,
                child: MaterialApp.router(
                  routerConfig: router,
                  showSemanticsDebugger:
                      GlobalState.showSemanticsDebugger.value,
                  showPerformanceOverlay:
                      GlobalState.showPerformanceOverlay.value,
                  debugShowCheckedModeBanner:
                      GlobalState.debugShowCheckedModeBanner.value,
                  themeAnimationDuration: Duration.zero,
                  theme: ThemeUtil.buildMaterialTheme(
                    context,
                    brightness: GlobalState.brightness,
                  ),
                  darkTheme: ThemeUtil.buildMaterialTheme(
                    context,
                    brightness: Brightness.dark,
                  ),
                  shortcuts: {
                    ...WidgetsApp.defaultShortcuts,
                    ...globalShortcuts(),
                  },
                  actions: {
                    ...WidgetsApp.defaultActions,
                    ...globalActions(),
                  },
                  builder: (context, child) => ScrollConfiguration(
                    behavior: const ElScrollBehavior(showTrack: true),
                    child: CupertinoTheme(
                      data: ThemeUtil.buildCupertinoThemeData(
                        context,
                        brightness: GlobalState.brightness,
                      ),
                      child: child!,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
