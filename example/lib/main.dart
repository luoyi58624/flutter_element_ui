import 'package:element_extension/element_extension.dart';
import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_obs/flutter_obs.dart';

void main() {
  runApp(const MainApp());
}

final isDark = Obs(false);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return ElApp(
        brightness: isDark.value ? Brightness.dark : Brightness.light,
        config: ElConfigData(
          themeDuration: Duration(milliseconds: 500),
        ),
        child: Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: isDark.value ? Brightness.dark : Brightness.light,
              ),
              themeAnimationDuration: context.elConfig.themeDuration,
              home: const HomePage(),
            );
          }
        ),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          ObsBuilder(builder: (context) {
            return IconButton(
              tooltip: isDark.value ? '切换亮色模式' : '切换黑暗模式',
              onPressed: () {
                isDark.value = !isDark.value;
              },
              icon: Icon(
                isDark.value ? Icons.dark_mode : Icons.light_mode,
              ),
              // color: context.elTheme.iconTheme.color,
            );
          }),
          const Gap(8),
        ],
      ),
      body: Center(
        child: ObsBuilder(builder: (context) {
          return H1('isDark: ${context.isDark}');
        }),
      ),
    );
  }
}
