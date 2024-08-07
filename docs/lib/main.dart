import 'package:docs/global.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FontUtil.init();
  // el.config = ElConfigData(
  //   textStyle: TextStyle(
  //     fontFamily: FlutterFont.fontFamily,
  //     fontFamilyFallback: ElFont.fontFamilyFallback,
  //   ),
  // );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ElThemeUtil.buildMaterialTheme(context),
      builder: (context, child) => ElConfigProvider(child: child!),
    );
  }
}
