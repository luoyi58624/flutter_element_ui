import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TabsPage extends HookWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activeIndex = useObs(2);
    final tabs = useObs(
      [
        ElGoogleTab(title: '标签页西那卡塞苏你显卡'),
        ElGoogleTab(title: 'axasxa'),
        ElGoogleTab(title: 'xasx'),
        ElGoogleTab(title: 'xasxasxasxasxas'),
        ...List.generate(
          5,
          (index) => ElGoogleTab(title: '标签页 - ${index + 1}'),
        ),
      ],
    );
    return ElTabs(activeIndex, children: tabs);
  }
}
