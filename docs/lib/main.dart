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
    return ObsBuilder(builder: (context) {
      return MaterialApp.router(
        routerConfig: router,
        theme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness:
              GlobalState.isDark.value ? Brightness.dark : Brightness.light,
        ),
        darkTheme: ElThemeUtil.buildMaterialTheme(
          context,
          brightness: Brightness.dark,
        ),
        builder: (context, child) => ElConfigProvider(
          brightness: Theme.of(context).brightness,
          child: child!,
        ),
      );
    });
  }
}

