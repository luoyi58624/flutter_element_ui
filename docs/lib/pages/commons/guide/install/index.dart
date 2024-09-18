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
          'ElApp 与 MaterialApp 不同，它只负责注入全局配置信息，所以你依然需要使用 MaterialApp 构建应用。',
          '而 ElApp.builder() 则是构建 TextTheme、ScrollConfiguration 等预设小部件，这些内容你可以自己实现。',
        ],
      ),
      textGap,
      const SectionCard(
        type: 'success',
        title: 'Tip',
        content: [
          'Element UI 允许你使用任意 App 构建应用，只不过 MaterialApp 是官方默认的构建方式。',
        ],
      ),
      textGap,
      CodeExampleWidget.code(code: code2),
      titleGap,
      const SectionCard(
        title: '使用声明式路由构建应用',
        content: [
          ElText([
            'Element UI 作为桌面端组件库，你应当使用声明式路由构建应用，相比命令式路由，'
                '声明式路由支持完善的导航历史功能，这里推荐使用官方提供的 ',
            ElLink(
              href: 'https://pub.dev/packages/go_router',
              child: 'go_router',
            ),
            '。',
          ]),
        ],
      ),
      textGap,
      CodeExampleWidget.code(code: code3),
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

String get code3 => '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

void main() {
  runApp(const MainApp());
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'child',
          builder: (context, state) => const ChildPage(),
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ElApp(
      child: MaterialApp.router(
        routerConfig: router,
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
      body: Center(
        child: ElButton(
          onPressed: () {
            context.push('/child');
          },
          child: '进入子页面',
        ),
      ),
    );
  }
}

class ChildPage extends StatelessWidget {
  const ChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('子页面'),
      ),
      body: Center(
        child: ElButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: '返回首页',
        ),
      ),
    );
  }
}''';
