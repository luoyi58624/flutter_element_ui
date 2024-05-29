import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: GlobalState.themeMode,
        builder: (context, value, _) {
          return ElApp(
            routerConfig: router,
            themeMode: value,
          );
        },
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
