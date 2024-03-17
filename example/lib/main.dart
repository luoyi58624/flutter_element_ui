import 'package:example/layout/layout.dart';
import 'package:example/pages/home.dart';
import 'package:example/utils/logger.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:macos_ui/macos_ui.dart';

import 'router.dart';
import 'store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalStore.isDark,
      builder: (context, value, child) {
        late Widget app;
        app = ElApp.router(
          routerConfig: router,
          theme: ElThemeData(
            brightness: value ? Brightness.dark : Brightness.light,
          ),
          builder: (context, child) => Theme(
            data: ThemeData(
              brightness: value ? Brightness.dark : Brightness.light,
            ),
            child: Material(
              child: child!,
            ),
            // child: FluentTheme(
            //   data: FluentThemeData(
            //     brightness: value ? Brightness.dark : Brightness.light,
            //   ),
            //   child: MacosTheme(
            //     data: MacosThemeData(
            //       brightness: value ? Brightness.dark : Brightness.light,
            //     ),
            //     child: child!,
            //   ),
            // ),
          ),
        );
        return app;
      },
    );
  }
}

// theme: ElThemeData(
//   primary: flag ? Colors.purple : Colors.blue,
//   success: const Color(0xff059669),
//   info: const Color(0xff64748B),
//   warning: const Color(0xfff59e0b),
//   error: const Color(0xffe11d48),
//   radius: 8,
// ),
