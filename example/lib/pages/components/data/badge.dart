import 'package:example/global.dart';
import 'package:flutter/material.dart';

class BadgePage extends HookWidget {
  const BadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    final badgeValue = useState(0);
    return Center(
      child: Column(
        children: [
          const Gap(8),
          ElBadge(
            badge: badgeValue.value,
            child: ElButton(
              '徽章 +1',
              onPressed: () {
                badgeValue.value++;
              },
              type: 'primary',
            ),
          ),
          const Gap(8),
          ElBadge(
            badge: badgeValue.value,
            child: ElButton(
              '徽章 -1',
              onPressed: () {
                if (badgeValue.value > 0) badgeValue.value--;
              },
              type: 'info',
            ),
          ),
          const Gap(8),
          ElBadge(
            badge: badgeValue.value,
            child: ElButton(
              '清空徽章',
              onPressed: () {
                badgeValue.value = 0;
              },
              type: 'error',
            ),
          ),
        ],
      ),
    );
  }
}
