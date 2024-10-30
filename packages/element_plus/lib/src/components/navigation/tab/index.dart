import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

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
    return ElTag(
      title,
      borderRadius: BorderRadius.zero,
    );
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
