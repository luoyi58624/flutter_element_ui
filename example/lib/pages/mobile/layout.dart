import 'package:example/global.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          navigationShell.goBranch(index);
        },
        currentIndex: navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: '设计',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compost),
            label: '组件',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apple),
            label: '资源',
          ),
        ],
      ),
    );
  }
}
