import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../../../temp_test.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      Demo3(),
    ];
  }
}
