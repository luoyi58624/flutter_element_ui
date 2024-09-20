import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class SliderPage extends ResponsivePage {
  const SliderPage({super.key});

  @override
  String get title => 'Slider 滑块';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
    ];
  }
}
