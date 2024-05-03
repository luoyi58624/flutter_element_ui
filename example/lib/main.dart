import 'package:flutter/material.dart';
import 'package:flutter_toast/flutter_toast.dart';
import 'package:mini_getx/mini_getx.dart';

import 'global.dart';

void main() async {
  Get.put(GlobalController());
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
            brightness: GlobalController.of.useDark.value ? Brightness.dark : Brightness.light,
          ),
          builder: FlutterToast.builder(
            (context, child) => Material(
              child: ElConfigProvider(
                useDark: GlobalController.of.useDark.value,
                config: GlobalController.of.elConfigData.value,
                child: child!,
              ),
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
