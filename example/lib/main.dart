import 'package:element_extension/element_extension.dart';
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
      return materialApp();
    });
  }

  Widget materialApp() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDark.value ? Brightness.dark : Brightness.light,
      ),
      home: const HomePage(),
    );
  }

  Widget cupertinoApp() {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: isDark.value ? Brightness.dark : Brightness.light,
      ),
      home: CupertinoHomePage(),
    );
  }

  Widget widgetsApp() {
    return WidgetsApp(
      // theme: CupertinoThemeData(
      //   brightness: isDark.value ? Brightness.dark : Brightness.light,
      // ),
      color: Colors.transparent,
      builder: (context, child) => CupertinoHomePage(),
    );
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
          return Text('isDark: ${context.isDark}');
        }),
      ),
    );
  }
}

class CupertinoHomePage extends StatelessWidget {
  const CupertinoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('首页'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ObsBuilder(builder: (context) {
              return CupertinoButton(
                onPressed: () {
                  isDark.value = !isDark.value;
                },
                padding: EdgeInsets.zero,
                child: Icon(
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
          return Text(
            'isDark: ${context.isDark}',
            style: TextStyle(
              color: context.isDark ? Colors.white : Colors.black,
            ),
          );
        }),
      ),
    );
  }
}
