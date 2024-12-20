import 'package:flutter/material.dart';

import '../../pages/home.dart';
import '../../pages/layout_header.dart';
import '../../pages/setting.dart';

class MobileHomeLayout extends StatelessWidget {
  const MobileHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LayoutHeader(),
        elevation: 0,
        scrolledUnderElevation: 2,
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
      body: const HomePage(),
    );
  }
}
