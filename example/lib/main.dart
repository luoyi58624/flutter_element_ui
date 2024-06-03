import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FontUtil.init();
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: GlobalState.brightness,
        builder: (context, value, _) {
          // return ElApp.router(
          //   routerConfig: router,
          //   brightness: value,
          //   textStyle: TextStyle(
          //     fontFamilyFallback: FontUtil.fontFamilyFallback,
          //   ),
          //   builder: (context, child) => Theme(
          //     data: ThemeData(),
          //     child: child!,
          //   ),
          // );
          return MaterialApp.router(
            routerConfig: router,
            builder: (context, child) => ElTheme(
              child: child!,
              config: ElConfigData(
                buttonStyle: ElButtonStyle(
                  height: 36,
                  radius: BorderRadius.circular(4),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// theme: ElThemeData(
//   primary: flag ? Colors.purple : Colors.blue,
//   success: const Color(0xff059669),
//   info: const Color(0xff64748B),
//   warning: const Color(0xfff59e0b),
//   error: const Color(0xffe11d48),
//   radius: 8,
// ),
