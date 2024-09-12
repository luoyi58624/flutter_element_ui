import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class InstallPage extends ResponsivePage {
  const InstallPage({super.key});

  @override
  String get title => '安装';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const SectionTitle('添加依赖'),
      CodeExampleWidget.code(code: code1),
      const SectionTitle('编辑 main.dart'),
      const SectionCard(
        title: 'Tip',
        content: [
          'ElApp 与 MaterialApp 不同，它的功能非常简单，只负责注入全局配置信息，'
              '所以你依然需要使用 MaterialApp 或其他顶级 APP 构建应用。',
          '而 ElApp.builder() 则是默认构建一些预设内容，例如：文本主题、滚动配置，而这些内容你完全可以自己实现，'
              '更多详细信息可以查阅源码。'
        ],
      ),
      textGap,
      CodeExampleWidget.code(code: code2),
    ];
  }
}

String get code1 => '''flutter pub add flutter_element_ui''';

String get code2 => '''
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElApp(
      child: MaterialApp(
        home: const HomePage(),
        builder: ElApp.builder(),
      ),
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
      ),
      body: const Center(
        child: ElButton(
          child: 'Hello'
        ),
      ),
    );
  }
}''';
