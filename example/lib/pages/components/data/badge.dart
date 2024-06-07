import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              style: const ElButtonStyle(
                type: ElThemeType.primary,
              ),
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
              style: const ElButtonStyle(
                type: ElThemeType.info,
              ),
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
              style: const ElButtonStyle(
                type: ElThemeType.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
