import 'package:flutter/material.dart';
import 'package:flutter_toast/flutter_toast.dart';
import 'package:luoyi_flutter_font/luoyi_flutter_font.dart';
import 'package:mini_getx/mini_getx.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterFont.loadNetworkFont(FlutterGoogleFonts.chineseFont());
  Get.put(GlobalController());
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  ThemeData _buildTheme() {
    return ThemeData(
      brightness: GlobalController.of.useDark.value ? Brightness.dark : Brightness.light,
      fontFamily: 'NotoSansSC',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: MaterialApp.router(
          routerConfig: router,
          theme: _buildTheme(),
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
