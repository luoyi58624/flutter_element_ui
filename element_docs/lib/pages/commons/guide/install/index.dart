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
      ElCodePreview(code: code2),
      titleGap,
      const SectionCard(title: 'Tip', content: [
        ElText([
          '如果你开发桌面应用，请使用声明式路由构建应用，相比命令式路由最大的优点在于它支持完善的导航历史功能，'
              '这里推荐使用官方提供的 ',
          ElLink(
            href: 'https://pub.dev/packages/go_router',
            child: 'go_router',
          ),
          '。',
        ]),
      ]),
      const SectionTitle('安装 go_router 依赖'),
      ElCodePreview(code: code3),
      const SectionTitle('修改 main.dart'),
      ElCodePreview(code: code4),
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
    // 1. ElApp 只负责注入全局数据，所以它的构造十分简单，您可以搭配任意顶级 App 构建应用
    return ElApp(
      child: MaterialApp(
        // 2. 您需要添加 navigatorKey，否则当你使用弹窗、消息等 api 时会报错
        navigatorKey: el.navigatorKey,
        home: const HomePage(),
        // 3. 在顶级 App 下面插入自定义小部件，内部代码不超过 10 行，您完全可以自己构造它们
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

String get code3 => '''flutter pub add go_router''';

String get code4 => '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:element_plus/element_plus.dart';

void main() {
  runApp(const MainApp());
}

final router = GoRouter(
  navigatorKey: el.navigatorKey,
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
            context.go('/child');
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
            context.pop();
          },
          child: '返回首页',
        ),
      ),
    );
  }
}''';
