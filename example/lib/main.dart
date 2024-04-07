import 'package:chicago/chicago.dart';
import 'package:example/controller/global.dart';
import 'package:example/pages/home.dart';

import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  await initFlutterApp();
  Get.put(GlobalController());
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => FlutterApp(
          router: router,
          useDark: GlobalController.of.useDark.value,
          builder: (context, child) => Material(
            child: ElConfigProvider(
              useDark: GlobalController.of.useDark.value,
              config: GlobalController.of.elConfigData.value,
              child: child!,
            ),
          ),
        ),
      ),
    );
  }
// Widget buildApp() {
//   return WidgetsApp.router(
//     color: const Color(0xffffffff),
//     routerConfig: router,
//     builder: (context, child) => ElConfigProvider(
//       config: ElConfigData(radius: 8),
//       child: child!,
//     ),
//   );
// }
}

// theme: ElThemeData(
//   primary: flag ? Colors.purple : Colors.blue,
//   success: const Color(0xff059669),
//   info: const Color(0xff64748B),
//   warning: const Color(0xfff59e0b),
//   error: const Color(0xffe11d48),
//   radius: 8,
// ),
