import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import '../../responsive_page.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final flag = useState(true);
    return [
      HoverBuilder(builder: (context) {
        return AnimatedContainer(
          duration: context.elThemeDuration ?? Duration.zero,
          width: 100,
          height: 100,
          color: context.isHover
              ? Colors.red
              : context.isDark
                  ? Colors.blue
                  : Colors.green,
        );
      }),
    ];
  }
}
