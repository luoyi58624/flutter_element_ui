import 'package:flutter/material.dart';

import '../commons/layout_header.dart';
import '../commons/setting.dart';

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
        actions: const [
          SizedBox.shrink(),
        ],
      ),
      endDrawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: const GlobalSetting(),
      ),
      body: child,
    );
  }
}
