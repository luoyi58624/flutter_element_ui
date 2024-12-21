import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class DragResizerPage extends ResponsivePage {
  const DragResizerPage({super.key});

  @override
  String get title => 'DragResizer 拖拽位置 + 拖拽尺寸';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
    ];
  }
}
