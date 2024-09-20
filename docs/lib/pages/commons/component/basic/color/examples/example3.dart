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

var primaryColor = ElThemeData.theme.primary;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElApp(
      theme: ElThemeData(
        primary: primaryColor,
      ),
      child: ElButton(
        onPressed: () {
          colorIndex++;
          primaryColor = colors[colorIndex % colors.length];
          ElUtils.refreshApp();
        },
        type: 'primary',
        child: 'Change Theme',
      ),
    );
  }
}

String get code => '''
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

void main() {
  runApp(const MainApp());
}

int colorIndex = 0;

List<Color> colors = [
  ElThemeData.theme.primary,
  Colors.orange,
  Colors.purple,
  Colors.green,
];

var primaryColor = ElThemeData.theme.primary;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElApp(
      theme: ElThemeData(
        primary: primaryColor,
      ),
      child: MaterialApp(
        home: ElButton(
          onPressed: () {
            colorIndex++;
            primaryColor = colors[colorIndex % colors.length];
            ElUtils.refreshApp();
          },
          type: 'primary',
          child: 'Change Theme',
        ),
      ),
    );
  }
}''';
