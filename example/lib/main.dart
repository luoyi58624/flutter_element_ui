import 'package:example/controller/global.dart';
import 'package:flutter/cupertino.dart';
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
          child: Builder(builder: (context) {
            return MaterialApp.router(
              routerConfig: router,
              themeMode: context.isDark ? ThemeMode.dark : ThemeMode.light,
              theme: ElThemeUtil.buildMaterialTheme(context),
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
                    child: child!,
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
