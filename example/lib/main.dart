import 'package:example/controller/global.dart';
import 'package:flutter/material.dart';
import 'package:mini_getx/mini_getx.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FontUtil.init();
  Get.put(GlobalController());
  runApp(const _App());
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
            fontFamily: FontUtil.fontFamily,
            fontFamilyFallback: FontUtil.fontFamilyFallback,
          ),
          child: child!,
        ),
      );
    });
  }
}
