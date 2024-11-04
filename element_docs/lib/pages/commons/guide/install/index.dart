import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class InstallPage extends ResponsivePage {
  const InstallPage({super.key});

  @override
  String get title => '安装';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const SectionTitle('添加依赖'),
      ElCodePreview(code: code1),
      const SectionTitle('编辑 main.dart'),
      const SectionCard(title: 'Tip', content: [
        ElText([
          '如果你开发桌面应用，请使用声明式路由构建应用，相比命令式路由最大的优点在于它支持完善的导航历史功能，'
              '这里推荐使用官方提供的 ',
          ElLink(
            href: 'https://pub.dev/packages/go_router',
            child: 'go_router',
          ),
          '，集成方式请自行查阅文档。',
        ]),
      ]),
      textGap,
      ElCodePreview(code: code2),
    ];
  }
}

String get code1 => '''flutter pub add element_plus''';

String get code2 => '''
import 'package:flutter/material.dart';
import 'package:element_plus/element_plus.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. ElApp 只负责注入全局主题数据，您可以搭配任意顶级 App 构建应用
    return ElApp(
      child: MaterialApp(
        // 2. 您需要添加 navigatorKey，否则使用 message 等 api 时会报错
        navigatorKey: el.navigatorKey,
        home: const HomePage(),
        // 3. ElApp.builder 主要是在导航器上方插入一个默认的 Overlay 遮罩小部件，否则通过 el.context 调用的 message 等 api 会报错
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
        title: const Text('Home'),
      ),
      body: ElButton(child: 'Hello'),
    );
  }
}''';
