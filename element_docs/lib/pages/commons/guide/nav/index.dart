import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      const ElButtonGroup(
        null,
        children: [
          ElButton(child: '选项一'),
          ElButton(child: '选项二'),
        ],
      ),
    ];
  }
}


