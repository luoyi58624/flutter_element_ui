import 'package:flutter/material.dart';

import '../global.dart';

abstract class LayoutPageBase extends HookWidget {
  const LayoutPageBase(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return context.sm
        ? buildMobileLayout(context)
        : buildDesktopLayout(context);
  }

  Widget buildMobileLayout(BuildContext context);

  Widget buildDesktopLayout(BuildContext context);
}

class LayoutPage extends LayoutPageBase {
  const LayoutPage(super.navigationShell, {super.key});

  @override
  Widget buildMobileLayout(context) {
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'Element UI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compost),
            label: 'Material',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apple),
            label: 'Cupertino',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Test',
          ),
        ],
      ),
    );
  }

  @override
  Widget buildDesktopLayout(context) {
    return Row(
      children: [
        NavigationRail(
          onDestinationSelected: (index) {
            navigationShell.goBranch(index);
          },
          selectedIndex: navigationShell.currentIndex,
          labelType: NavigationRailLabelType.all,
          trailing: ObsBuilder(builder: (context) {
            return Switch(
              value: GlobalState.isDark.value,
              onChanged: (v) => GlobalState.isDark.value = v,
            );
          }),
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.ac_unit),
              label: Text('Element UI'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.compost),
              label: Text('Material'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.apple),
              label: Text('Cupertino'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              label: Text('Test'),
            ),
          ],
        ),
        const ElDivider(vertical: true),
        Expanded(child: navigationShell),
      ],
    );
  }
}
