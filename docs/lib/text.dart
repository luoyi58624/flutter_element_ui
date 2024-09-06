import 'package:docs/global.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _ElApp());
}

final isDark = Obs(false);

Brightness get brightness => isDark.value ? Brightness.dark : Brightness.light;

class _ElApp extends StatelessWidget {
  const _ElApp();

  @override
  Widget build(BuildContext context) {
    el.themeDuration = Duration.zero;
    return ObsBuilder(builder: (context) {
      return MaterialApp(
        home: HomePage(),
        theme: ThemeData(brightness: brightness),
        themeMode: ThemeMode.dark,
        themeAnimationDuration: el.themeDuration,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ElConfigProvider(
          brightness: brightness,
          child: child!,
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
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElSwitch(isDark),
          ),
        ],
      ),
      body: Center(
        child: HoverBuilder(builder: (context) {
          return ElText(
            '文字',
            duration: 300.ms,
            style: context.isHover
                ? const TextStyle(
                    fontSize: 50,
                    color: Colors.blue,
                  )
                : null,
          );
        }),
      ),
    );
  }
}
