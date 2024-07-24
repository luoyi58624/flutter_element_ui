import 'package:docs/global.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FontUtil.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElApp(
      data: ElAppData(
        config: ElConfigData(
          textStyle: TextStyle(
            fontFamily: FlutterFont.fontFamily,
            fontFamilyFallback: ElFont.fontFamilyFallback,
          ),
        ),
      ),
      child: MaterialApp.router(
        routerConfig: router,
        color: Colors.transparent,
        theme: ElThemeUtil.buildMaterialTheme(context),
        darkTheme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness: Brightness.dark,
        ),
        builder: (context, child) => Material(
          child: AnimatedColoredBox(
            duration: context.elConfig.bgTransition.ms,
            color: context.elTheme.bgColor,
            child: ScrollConfiguration(
              behavior: const ElScrollBehavior(),
              child: Overlay(initialEntries: [
                OverlayEntry(builder: (context) {
                  return child!;
                }),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
