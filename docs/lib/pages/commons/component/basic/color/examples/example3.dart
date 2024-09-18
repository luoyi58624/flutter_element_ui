import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class Example3 extends StatelessWidget {
  const Example3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('动态全局主题色'),
        const SectionText('下面代码以最简单的方式展示如何更新全局主题，你可以直接复制到 main.dart 中运行'),
        textGap,
        CodeExampleWidget(
          code: code,
          expanded: true,
          children: const [
            SizedBox(
              height: 300,
              child: MainApp(),
            ),
          ],
        ),
      ],
    );
  }
}

int colorIndex = 0;

List<Color> colors = [
  ElThemeData.theme.primary,
  Colors.purple,
  Colors.green,
  Colors.cyan
];

/// 主题色响应式变量，ValueNotifier 是官方提供的简易状态器
final primaryColor = ValueNotifier(ElThemeData.theme.primary);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 当 primaryColor 发生变化时，将自动重建小部件
    return ValueListenableBuilder(
      valueListenable: primaryColor,
      builder: (context, value, _) {
        return ElApp(
          theme: ElThemeData(
            primary: value,
          ),
          child: MaterialApp(
            home: const HomePage(),
            builder: ElApp.builder(),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: ElButton(
          onPressed: () {
            colorIndex++;
            primaryColor.value = colors[colorIndex % colors.length];
          },
          type: 'primary',
          child: 'Change Theme',
        ),
      ),
    );
  }
}

String get code => '''
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

int colorIndex = 0;

List<Color> colors = [
  ElThemeData.theme.primary,
  Colors.purple,
  Colors.green,
  Colors.cyan
];

/// 主题色响应式变量，ValueNotifier 是官方提供的简易状态器
final primaryColor = ValueNotifier(ElThemeData.theme.primary);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 当 primaryColor 发生变化时，将自动重建小部件
    return ValueListenableBuilder(
      valueListenable: primaryColor,
      builder: (context, value, _) {
        return ElApp(
          theme: ElThemeData(
            primary: value,
          ),
          child: MaterialApp(
            home: const HomePage(),
            builder: ElApp.builder(),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: ElButton(
          onPressed: () {
            colorIndex++;
            primaryColor.value = colors[colorIndex % colors.length];
          },
          type: 'primary',
          child: 'Change Theme',
        ),
      ),
    );
  }
}''';
