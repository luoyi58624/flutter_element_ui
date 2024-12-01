import 'package:element_docs/global.dart';
import 'package:element_docs/pages/component/basic/button/index.dart';
import 'package:flutter/material.dart';

import 'nest_scroll.dart';

/// 测试页面，Ctrl + D 快捷键进入
class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('测试页面'),
      ),
      body: const ColumnWidget(
        scroll: true,
        repaintBoundary: true,
        children: [
          CardWidget(
            title: 'UI 测试',
            elevation: 1,
            children: [
              CellWidget(title: '嵌套滚动测试', page: NestScrollTest()),
              CellWidget(title: '自定义滚动', page: _Demo()),
              CellWidget(title: '自定义滚动', page: _Test()),
            ],
          ),
        ],
      ),
    );
  }
}

class _Test extends StatelessWidget {
  const _Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView.builder(
        itemCount: 1000,
        itemBuilder: (context, index) => _Item(index: index),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    i('build - ${index + 1}');
    return Focus(
      child: Builder(builder: (context) {
        return ElEvent(
          behavior: HitTestBehavior.opaque,
          onTapDown: (e) {
            Focus.of(context).requestFocus();
          },
          child: Ink(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Focus.of(context).hasFocus ? Colors.green : null,
            ),
            child: Text(
              'item - ${index + 1}',
            ),
          ),
        );
      }),
    );
  }
}

class _Demo extends StatelessWidget {
  const _Demo({super.key});

  @override
  Widget build(BuildContext context) {
    final page = const ButtonPage().buildPage(context) * 1000;
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义滚动'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(50),
            sliver: SuperSliverList.builder(
              itemCount: page.length,
              itemBuilder: (context, index) => page[index],
            ),
          ),
        ],
      ),
    );
  }
}
