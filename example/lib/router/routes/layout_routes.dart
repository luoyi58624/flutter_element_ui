import 'package:go_router/go_router.dart';

import '../../layout/layout.dart';
import '../../pages/components/basic/button.dart';
import '../../pages/components/basic/color.dart';
import '../../pages/components/data/table.dart';
import '../../pages/home.dart';
import '../../pages/test/border.dart';

const String _components = '/components';
const String _componentsBasic = '$_components/basic';
const String _componentsData = '$_components/data';
const String _tests = '/tests';

final layoutRoutes = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) => LayoutPage(navigationShell: navigationShell),
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '$_componentsBasic/button',
          builder: (context, state) => const ButtonPage(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '$_componentsBasic/color',
          builder: (context, state) => const ColorPage(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '$_componentsData/table',
          builder: (context, state) => const TablePage(),
        ),
      ],
    ),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '/test',
          redirect: (context, state) => '/test/border',
          routes: [
            GoRoute(
              path: 'border',
              builder: (context, state) => const BorderTestPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
