import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TabsPage extends HookWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final active = useState(0);
    return Column(
      children: [
        // ElTabs(
        //   active,
        //   type: ElTabType.google,
        //   children: [
        //     ...List.generate(
        //       10,
        //       (index) => ElTab(
        //         title: '标签页 - ${index + 1}',
        //       ),
        //     ),
        //     ...List.generate(
        //       10,
        //       (index) => ElTab(
        //         title: '其他标签页 - ${index + 1}',
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
