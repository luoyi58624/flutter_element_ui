import 'package:element_docs/shortcuts/global_shortcut.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global.dart';
import 'pages/test/test_page.dart';
import 'utils/app_theme.dart';
import 'utils/element_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setPathUrlStrategy();
  // await initFont(
  //   windows: true,
  // );
  // if (PlatformUtil.isWindows) {
  //   ElFont.bold = FontWeight.w700;
  // }
  runApp(const MainApp());
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return const ElApp(
      child: MaterialApp(home: _HomePage()),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: const FocusExample2(),
    );
  }
}

class FocusExample2 extends HookWidget {
  const FocusExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          focusWidget,
          focusWidget,
          focusWidget,
        ],
      ),
    );
  }

  Widget get focusWidget {
    late FocusNode focusNode;
    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: Focus(
        autofocus: true,
        child: Builder(builder: (context) {
          focusNode = Focus.of(context);
          return Container(
            width: 250,
            height: 100,
            color: focusNode.hasFocus ? Colors.grey : Colors.grey.shade200,
            child: const FocusScope(
              child: Center(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _DemoWidget(),
                    _DemoWidget(),
                    _DemoWidget(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _DemoWidget extends StatefulWidget {
  const _DemoWidget({super.key});

  @override
  State<_DemoWidget> createState() => _DemoWidgetState();
}

class _DemoWidgetState extends State<_DemoWidget> {
  @override
  void dispose() {
    super.dispose();
    w('卸载');
  }

  @override
  Widget build(BuildContext context) {
    late FocusNode focusNode;
    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: Focus(
        child: Builder(
          builder: (context) {
            focusNode = Focus.of(context);
            return Container(
              width: 50,
              height: 50,
              color: focusNode.hasFocus ? Colors.red : Colors.grey.shade300,
            );
          }
        ),
      ),
    );
  }
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
    RouterState.isMobile.value = context.sm;
    GlobalState.globalFontSize = context.sm ? 15 : 16;
    MainApp.currentThemeMode = ThemeMode.system;
    if (MainApp.currentThemeMode == ThemeMode.system) {
      if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
        MainApp.currentThemeMode = ThemeMode.dark;
      }
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyP, shift: true): () {
          el.message.success('hello');
        }
      },
      child: ObsBuilder(builder: (context) {
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
                showPerformanceOverlay:
                    GlobalState.showPerformanceOverlay.value,
                themeAnimationDuration: Duration.zero,
                theme: ElThemeUtil.buildMaterialTheme(
                  context,
                  brightness: GlobalState.brightness,
                ),
                darkTheme: ElThemeUtil.buildMaterialTheme(
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
      }),
    );
  }
}
