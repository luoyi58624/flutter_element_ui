import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.elTheme.bgColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: context.elTheme.error,
              ),
              child: const ElIcon(
                ElIcons.close,
                color: Colors.white,
              ),
            ),
            const Gap(16),
            const H4('找不到资源'),
            const Gap(4),
            const ElText(
              '请求的页面不存在。',
              style: TextStyle(fontSize: 14),
            ),
            const Gap(8),
            ElButton(
              onPressed: () {
                context.go('/');
              },
              child: '回到首页',
            ),
          ],
        ),
      ),
    );
  }
}
