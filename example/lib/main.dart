import 'package:chicago/chicago.dart';
import 'package:example/layout/layout.dart';
import 'package:example/pages/home.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

import 'router.dart';
import 'state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return buildApp();
  }

  Widget buildApp() {
    return WidgetsApp.router(
      color: const Color(0xffffffff),
      routerConfig: router,
      builder: (context, child) => ValueListenableBuilder(
        valueListenable: GlobalState.isDark,
        builder: (c, v, _) {
          return ElConfigProvider(
            useDark: v,
            child: child!,
          );
        },
      ),
    );
  }

  Widget buildMaterialApp() {
    return MaterialApp.router(
      routerConfig: router,
      builder: (context, child) => ElConfigProvider(
        child: child!,
      ),
    );
    // return MaterialApp.router(
    //   routerConfig: router,
    //   debugShowCheckedModeBanner: false,
    //   builder: (context, child) => ValueListenableBuilder(
    //     valueListenable: GlobalState.isDark,
    //     builder: (context, value, _) {
    //       return Material(
    //         child: ElConfigProvider(
    //           useDark: value,
    //           child: child!,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  Widget buildFluentApp() {
    return fluent.FluentApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
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
