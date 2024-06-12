import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FontUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: 'Flutter Demo',
      color: Colors.transparent,
      onGenerateRoute: (context) => MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      builder: (context, child) => ElTheme(child: child!),
    );
  }
}
