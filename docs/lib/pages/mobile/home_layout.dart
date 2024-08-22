import 'package:flutter/material.dart';

import '../commons/home.dart';
import '../commons/layout_header.dart';

class MobileHomeLayout extends StatelessWidget {
  const MobileHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LayoutHeader(),
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
      body: const HomePage(),
    );
  }
}
