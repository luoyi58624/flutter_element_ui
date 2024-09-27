import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    final flag = useState(true);
    return [
      ElSwitch(flag),
      const Gap(80),
      SizedBox(
        height: 300,
        child: Row(
          children: AxisDirection.values
              .map(
                (e) => Expanded(
                  child: ElProgress.animate(90, axis: e),
                ),
              )
              .toList(),
        ),
      ),
    ];
  }
}
