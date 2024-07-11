import 'package:example/controller/global.dart';
import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(GlobalController());
  runApp(const _App());

  // ((int n) {
  //   print(n);
  //   print('我是自执行方法');
  // })(12);
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MaterialApp.router(
        routerConfig: router,
        themeMode:
            GlobalController.of.isDark.value ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(),
        darkTheme: ThemeData(brightness: Brightness.dark),
        builder: (context, child) => ElTheme(
          brightness: Theme.of(context).brightness,
          textStyle: TextStyle(
            fontFamily: FlutterFont.fontFamily,
            fontFamilyFallback: FlutterFont.fontFamilyFallback,
          ),
          child: child!,
        ),
      );
    });
  }
}
