import 'package:docs/pages/commons/responsive_page.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class IconPage extends ResponsivePage {
  const IconPage({super.key});

  @override
  String get title => 'Icon 图标';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      Example1(),
    ];
  }
}
