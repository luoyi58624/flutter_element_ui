import 'package:example/global.dart';
import 'package:example/pages/test/pages/debug_setting.dart';
import 'package:flutter/material.dart';

import 'pages/canvas/arc.dart';
import 'pages/canvas/circle.dart';
import 'pages/canvas/face.dart';
import 'pages/canvas/line.dart';
import 'pages/canvas/path.dart';
import 'pages/canvas/point.dart';
import 'pages/canvas/rect.dart';
import 'pages/canvas/triangle.dart';
import 'pages/font.dart';
import 'pages/http.dart';
import 'pages/multi_child.dart';
import 'pages/overlay.dart';
import 'pages/render/leaf.dart';
import 'pages/render/multi.dart';
import 'pages/render/single.dart';

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
          CellWidget(title: 'Font 测试', page: FontTestPage()),
          CellWidget(title: 'Http 测试', page: HttpPage()),
          CellWidget(title: 'Overlay 测试', page: OverlayPage()),
          CellWidget(title: 'Leaf Render', page: LeafRenderTestPage()),
          CellWidget(title: 'Single Render', page: SingleRenderTestPage()),
          CellWidget(title: 'Multi Render', page: MultiRenderTestPage()),
          CellWidget(title: 'MultiChild 自定义布局测试', page: MultiChildTestPage()),
          CellWidget(title: 'Canvas Line', page: LinePage()),
          CellWidget(title: 'Canvas Point', page: PointPage()),
          CellWidget(title: 'Canvas Circle', page: CirclePage()),
          CellWidget(title: 'Canvas Arc', page: ArcPage()),
          CellWidget(title: 'Canvas Rect', page: RectPage()),
          CellWidget(title: 'Canvas Path', page: PathPage()),
          CellWidget(title: 'Canvas 三角形', page: TrianglePage()),
          CellWidget(title: 'Canvas 笑脸', page: FacePage()),
        ],
      ),
    );
  }
}
