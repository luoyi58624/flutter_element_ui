import 'package:chicago/chicago.dart';
import 'package:example/pages/home.dart';

import 'package:flutter/material.dart';

import 'global.dart';
import 'router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: buildMaterialApp());
  }

  Widget buildApp() {
    return WidgetsApp.router(
      color: const Color(0xffffffff),
      routerConfig: router,
      builder: (context, child) => ValueListenableBuilder(
        valueListenable: GlobalState.isDark,
        builder: (context, value, _) {
          return ElConfigProvider(
            useDark: value,
            child: child!,
          );
        },
      ),
    );
  }

  Widget buildMaterialApp() {
    return FlutterApp(
      router: router,
      builder: (context, child) => ValueListenableBuilder(
        valueListenable: GlobalState.isDark,
        builder: (context, value, _) {
          return Material(
            child: ElConfigProvider(
              useDark: value,
              child: child!,
            ),
          );
        },
      ),
    );
    // return ValueListenableBuilder(
    //   valueListenable: GlobalState.isDark,
    //   builder: (context, value, _) {
    //     return FlutterApp(
    //       router: router,
    //       // useDark: value,
    //       config: FlutterConfigData(fontFamily: 'NotoSansSC'),
    //       builder: (context, child) => Material(
    //         child: ElConfigProvider(
    //           useDark: value,
    //           child: child!,
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  Widget buildChicagoApp() {
    return ChicagoApp(
      home: ValueListenableBuilder(
        valueListenable: GlobalState.isDark,
        builder: (context, value, _) {
          return ElConfigProvider(
            useDark: value,
            child: ElMain(child: const HomePage()),
          );
        },
      ),
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
