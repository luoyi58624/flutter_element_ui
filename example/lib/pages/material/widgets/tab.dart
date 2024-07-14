import 'package:flutter/material.dart';
import 'package:example/global.dart';

import 'common.dart';

class TabWidget extends HookWidget {
  const TabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      title: '导航栏',
      children: [
        buildMaterial2(context),
        const Gap(16),
        buildMaterial3(context),
        const Gap(16),
        buildTab(),
        const Gap(16),
        buildTab2(),
        const Gap(16),
        buildTab3(),
      ],
    );
  }

  Widget buildMaterial2(BuildContext context) {
    final currentIndex = useState(0);
    return BottomNavigationBar(
      onTap: (index) => currentIndex.value = index,
      currentIndex: currentIndex.value,
      items: const [
        BottomNavigationBarItem(
          icon: Badge(
            label: Text('10'),
            child: Icon(Icons.home),
          ),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.home),
          ),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: Badge(
            label: Text('1'),
            child: Icon(Icons.home),
          ),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: Badge(
            label: Text('288'),
            child: Icon(Icons.home),
          ),
          label: '首页',
        ),
      ],
    );
  }

  Widget buildMaterial3(BuildContext context) {
    final currentIndex = useState(0);
    return NavigationBar(
      onDestinationSelected: (index) => currentIndex.value = index,
      selectedIndex: currentIndex.value,
      destinations: const [
        NavigationDestination(
          icon: Badge(
            label: Text('10'),
            child: Icon(Icons.home),
          ),
          label: '首页',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.home),
          ),
          label: '首页',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('1'),
            child: Icon(Icons.home),
          ),
          label: '首页',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('288'),
            child: Icon(Icons.home),
          ),
          label: '首页',
        ),
      ],
    );
  }

  Widget buildTab() {
    final tabController = useTabController(initialLength: 3);
    return TabBar(
      controller: tabController,
      tabs: const <Widget>[
        Tab(icon: Icon(Icons.videocam_outlined), text: 'Video'),
        Tab(icon: Icon(Icons.photo_outlined), text: 'Photos'),
        Tab(icon: Icon(Icons.audiotrack_sharp), text: 'Audio'),
      ],
    );
  }

  Widget buildTab2() {
    final tabController = useTabController(initialLength: 3);
    return TabBar(
      controller: tabController,
      tabs: const <Widget>[
        Tab(icon: Icon(Icons.videocam_outlined), text: '选项一'),
        Tab(icon: Icon(Icons.photo_outlined), text: '选项二'),
        Tab(icon: Icon(Icons.audiotrack_sharp), text: '选项三'),
      ],
    );
  }

  Widget buildTab3() {
    final tabController = useTabController(initialLength: 3);
    return TabBar(
      controller: tabController,
      tabs: const <Widget>[
        Tab(text: '选项一'),
        Tab(text: '选项二'),
        Tab(text: '选项三'),
      ],
    );
  }
}
