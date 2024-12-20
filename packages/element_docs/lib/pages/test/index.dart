import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'animate_obs.dart';
import 'animate_value_generate.dart';
import 'box_shadow_test_page.dart';
import 'local_obs.dart';
import 'local_obs_list.dart';
import 'local_obs_map.dart';
import 'local_storage.dart';
import 'nest_scroll.dart';
import 'session_storage.dart';
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
              CellWidget(title: 'LocalObs 测试', page: LocalObsTest()),
              CellWidget(title: 'LocalObs List 测试', page: LocalObsListTest()),
              CellWidget(title: 'LocalObs Map 测试', page: LocalObsMapTest()),
              CellWidget(
                title: 'localStorage 测试',
                page: LocalStorageTestPage(),
              ),
              CellWidget(
                title: 'sessionStorage 测试',
                page: SessionStorageTestPage(),
              ),
              CellWidget(
                title: '动画 Value 生成测试',
                page: AnimateValueGeneratePage(),
              ),
              CellWidget(title: '节流测试', page: ThrottleTestPage()),
              CellWidget(title: '阴影生成', page: BoxShadowTestPage()),
            ],
          ),
        ],
      ),
    );
  }
}
