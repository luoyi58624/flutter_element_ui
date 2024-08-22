import 'package:flutter/material.dart';

import '../commons/layout_header.dart';


class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LayoutHeader(),
        elevation: 1,
        scrolledUnderElevation: 1,
      ),
      body: child,
    );
  }
}
