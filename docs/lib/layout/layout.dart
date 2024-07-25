import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key, required this.child});

  final Widget child;

  Widget buildHeader(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            ElHover(
              onlyCursor: true,
              cursor: SystemMouseCursors.click,
              builder: (isHover) {
                return GestureDetector(
                  onTap: () {
                    context.go('/');
                  },
                  child: ElIcon(
                    'assets/images/element-plus-logo.svg',
                    color: context.elTheme.primary,
                    size: 28,
                    package: null,
                  ),
                );
              },
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeader(context),
        const ElDivider(),
        Expanded(child: child),
      ],
    );
  }
}
