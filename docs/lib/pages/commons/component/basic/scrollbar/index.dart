import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class ScrollbarPage extends ResponsivePage {
  const ScrollbarPage({super.key});

  @override
  String get title => 'Scrollbar 滚动条';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      titleGap,
      SectionText('Element UI 风格滚动条，其特征是当鼠标进入滚动区域时将立即显示，当离开滚动区域则立即隐藏。'),
      Example1(),
      Example2(),
    ];
  }
}
