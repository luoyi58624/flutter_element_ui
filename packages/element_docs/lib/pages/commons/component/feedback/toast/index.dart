import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class ToastPage extends ResponsivePage {
  const ToastPage({super.key});

  @override
  String get title => 'Toast 轻提示';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '主色'),
    ];
  }
}
