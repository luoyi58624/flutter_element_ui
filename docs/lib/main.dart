import 'package:docs/global.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElApp(
      child: WidgetsApp.router(
        routerConfig: router,
        color: Colors.transparent,
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
