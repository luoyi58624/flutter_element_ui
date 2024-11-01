import 'package:element_extension/element_extension.dart';
import 'package:element_plus/element_plus.dart';
import 'package:flutter/cupertino.dart';
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
        child: Builder(builder: (context) {
          return CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              brightness: isDark.value ? Brightness.dark : Brightness.light,
            ),
            home: HomePage(),
          );
        }),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('首页'),
        trailing: Row(
          children: [
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
      ),
      child: Center(
        child: ObsBuilder(builder: (context) {
          return ElButton(child: 'isDark: ${context.isDark}');
        }),
      ),
    );
  }
}
