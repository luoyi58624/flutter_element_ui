import 'package:example/global.dart';
import 'package:example/pages/test/pages/debug_setting.dart';
import 'package:flutter/material.dart';

import 'pages/http.dart';
import 'pages/multi_child.dart';
import 'pages/overlay.dart';
import 'pages/render.dart';

class TestHomePage extends HookWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('其他测试'),
      ),
      body: const ColumnWidget(
        scroll: true,
        children: [
          CellWidget(title: 'Debug 开发设置', page: DebugSettingPage()),
          CellWidget(title: 'Http 测试', page: HttpPage()),
          CellWidget(title: 'Overlay 测试', page: OverlayPage()),
          CellWidget(title: 'Render 自定义渲染', page: RenderTestPage()),
          CellWidget(title: 'MultiChild 自定义布局测试', page: MultiChildTestPage()),
        ],
      ),
    );
  }
}
