import 'package:docs/pages/commons/responsive_page.dart';
import 'package:flutter/material.dart';

import 'examples/01.dart';

class ButtonPage extends ResponsivePage {
  const ButtonPage({super.key});

  @override
  String get title => 'Button 按钮';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      Example1(),
    ];
  }
}
