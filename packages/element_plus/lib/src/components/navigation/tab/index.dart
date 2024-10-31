import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import '../../../themes/components/navigation/tabs.dart';
import '../../data/tag/index.dart';
import '../tabs/index.dart';

class ElTab extends StatelessWidget {
  const ElTab({
    super.key,
    required this.title,
    this.icon,
  });

  final String title;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final $bgColor = ElTabs.of(context).bgColor;
    return ElHoverBuilder(builder: (context) {
      return ElTag(
        title,
        // height: 28,
        borderRadius: BorderRadius.zero,
        bgColor: context.isHover ? $bgColor.darken(30) : $bgColor,
        closable: true,
      );
    });
    // return ElHoverBuilder(builder: (context) {
    //   return Container(
    //     child: Row(
    //       children: [
    //         ElText(title),
    //       ],
    //     ),
    //   );
    // });
  }
}
