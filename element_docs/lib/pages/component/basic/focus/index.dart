import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class FocusPage extends ResponsivePage {
  const FocusPage({super.key});

  @override
  String get title => 'Focus 焦点';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
    ];
  }
}
