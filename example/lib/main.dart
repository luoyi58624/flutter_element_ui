import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  await CacheInterceptor.init();
  await FontUtil.init();
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return ElApp(
        brightness:
            GlobalState.isDark.value ? Brightness.dark : Brightness.light,
        data: ElAppData(
          config: ElConfigData(
            textStyle: TextStyle(
              fontFamily: FlutterFont.fontFamily,
              fontFamilyFallback: ElFont.fontFamilyFallback,
            ),
          ),
        ),
        child: ObsBuilder(builder: (context) {
          return MaterialApp.router(
            routerConfig: router,
            themeMode: context.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ElThemeUtil.buildMaterialTheme(context),
            showPerformanceOverlay: GlobalState.showPerformanceOverlay.value,
            darkTheme: ElThemeUtil.buildMaterialTheme(
              context,
              brightness: Brightness.dark,
            ),
            builder: (context, child) => Material(
              child: CupertinoTheme(
                data: ElThemeUtil.buildCupertinoThemeData(
                  context,
                  brightness: context.brightness,
                ),
                child: ScrollConfiguration(
                  behavior: const ElScrollBehavior(),
                  child: Overlay(initialEntries: [
                    OverlayEntry(builder: (context) {
                      $el.overlayContext = context;
                      return child!;
                    }),
                  ]),
                ),
              ),
            ),
          );
        }),
      );
    });
  }
}
