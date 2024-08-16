import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key, required this.child});

  final Widget child;

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          A(
            href: '/',
            child: GestureDetector(
              onTap: () {
                context.go('/');
              },
              child: ElIcon(
                'assets/images/element-plus-logo.svg',
                color: context.elTheme.primary,
                size: 28,
                package: null,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildHeader(context),
      ),
      body: Column(
        children: [
          const ElDivider(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
