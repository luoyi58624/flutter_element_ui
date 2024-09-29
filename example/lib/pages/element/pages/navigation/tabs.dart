import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TabsPage extends HookWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activeIndex = useObs(2);
    final tabs = useObs(
      [
        const ElGoogleTab(title: '标签页西那卡塞苏你显卡'),
        const ElGoogleTab(title: 'axasxa'),
        const ElGoogleTab(title: 'xasx'),
        const ElGoogleTab(title: 'xasxasxasxasxas'),
        ...List.generate(
          5,
          (index) => ElGoogleTab(title: '标签页 - ${index + 1}'),
        ),
      ],
    );
    return ElTabs(activeIndex, children: tabs);
  }
}
