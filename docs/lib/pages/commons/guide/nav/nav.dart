import 'package:docs/global.dart';
import 'package:docs/widgets/test.dart';
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
      ElHoverBuilder(builder: (context) {
        return AnimatedContainer(
          duration: context.themeDuration ?? Duration.zero,
          width: 100,
          height: 100,
          color: context.isHover ? Colors.red : Colors.green,
        );
      }),
    ];
  }
}
