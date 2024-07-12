import 'package:example/controller/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GlobalController());
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ElTheme(
          brightness: GlobalController.of.isDark.value
              ? Brightness.dark
              : Brightness.light,
          data: ElThemeData(
            theme: ElBrightnessData(
              primary: Colors.purple,
            ),
          ),
          child: Builder(builder: (context) {
            return MaterialApp.router(
              routerConfig: router,
              themeMode: context.isDark ? ThemeMode.dark : ThemeMode.light,
              theme: ThemeData(),
              darkTheme: ThemeData(brightness: Brightness.dark),
              builder: (context, child) => Material(
                child: ScrollConfiguration(
                  behavior: const ElScrollBehavior(),
                  child: child!,
                ),
              ),
            );
          }),
        ));
  }
}
