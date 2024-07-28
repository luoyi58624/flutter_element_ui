import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TabsPage extends HookWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = useState(0);
    return Column(
      children: [
        ElTabs(
          selected,
          tabs: [
            ...List.generate(
              10,
              (index) => ElTab(
                id: index,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
