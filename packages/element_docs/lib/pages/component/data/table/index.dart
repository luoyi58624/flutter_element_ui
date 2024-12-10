import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class TablePage extends ResponsivePage {
  const TablePage({super.key});

  @override
  String get title => 'Table 表格';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
    ];
  }
}
