import 'package:docs/global.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  el.lightTheme = ElThemeData(
    bgColor: Colors.white,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return ElApp.router(
        routerConfig: router,
        // themeAnimationStyle: AnimationStyle(
        //   duration: 200.ms,
        // ),
        // theme: ElThemeUtil.buildMaterialTheme(
        //   context,
        //   brightness:
        //       GlobalState.isDark.value ? Brightness.dark : Brightness.light,
        // ),
        // darkTheme: ElThemeUtil.buildMaterialTheme(
        //   context,
        //   brightness: Brightness.dark,
        // ),
      );
    });
  }
}
