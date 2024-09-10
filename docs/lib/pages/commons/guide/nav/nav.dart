import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import '../../responsive_page.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      ElHoverBuilder(builder: (context) {
        return AnimatedContainer(
          duration: 100.ms,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              width: context.isHover ? 4 : 0.00000000001,
              color: Colors.red,
            ),
          ),
        );
      }),
    ];
  }
}
