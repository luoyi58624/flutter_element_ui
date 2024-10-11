import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class Example3 extends StatelessWidget {
  const Example3({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionText('下面代码以最简单的方式展示如何更新全局主题'),
        textGap,
        FlatCodeExample(
          code: code,
          noBorderRadius: true,
          child: const MainApp(),
        ),
      ],
    );
  }
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
      // 演示代码就不可以再嵌套 MaterialApp 了，否则路由系统会出现异常
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Center(
          child: ElButton(
            onPressed: () {
              colorIndex++;
              primaryColor = colors[colorIndex % colors.length];
              // 刷新应用状态，正常情况下你应当使用状态管理
              ElUtil.refreshApp();
            },
            type: 'primary',
            child: 'Change Theme',
          ),
        ),
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
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Example'),
          ),
          body: Center(
            child: ElButton(
              onPressed: () {
                colorIndex++;
                primaryColor = colors[colorIndex % colors.length];
                // 刷新应用状态，正常情况下你应当使用状态管理
                ElUtil.refreshApp(); 
              },
              type: 'primary',
              child: 'Change Theme',
            ),
          ),
        ),
      ),
    );
  }
}''';
