import 'package:element_docs/global.dart';
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
              CellWidget(
                title: '嵌套滚动测试',
                page: NestScrollTest(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
