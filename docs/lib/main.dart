import 'package:docs/global.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  el.theme = ElThemeData(
    bgColor: Colors.white,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp(
    //   themeAnimationStyle: ,
    // );
    context.sm
        ? routingConfig.value = mobileRoutingConfig
        : routingConfig.value = desktopRoutingConfig;
    return ObsBuilder(builder: (context) {
      final brightness =
          GlobalState.isDark.value ? Brightness.dark : Brightness.light;
      return ElApp.router(
        routerConfig: router,
        brightness: brightness,
        builder: (context, child) => Theme(
          data: ElThemeUtil.buildMaterialTheme(context, brightness: brightness),
          child: child!,
        ),
      );
    });
  }
}
