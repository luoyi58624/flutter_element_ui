import 'package:element_docs/global.dart';
import 'package:element_docs/pages/component/basic/button/index.dart';
import 'package:flutter/material.dart';

import 'animate_obs.dart';
import 'animate_value_generate.dart';
import 'local_obs.dart';
import 'nest_scroll.dart';
import 'throttle_test_page.dart';

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
              CellWidget(title: '动画 Obs 测试', page: AnimateObsTestPage()),
              CellWidget(title: '本地持久化 Obs 测试', page: LocalObsTest()),
              CellWidget(
                  title: '动画 Value 生成测试', page: AnimateValueGeneratePage()),
              CellWidget(title: '节流测试', page: ThrottleTestPage()),
            ],
          ),
        ],
      ),
    );
  }
}
