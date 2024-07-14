import 'package:example/global.dart';
import 'package:example/pages/cupertino/cupertino.dart';
import 'package:example/pages/material/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/layout.dart';
import 'pages/home/home.dart';
import 'routes/element.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    if (state.fullPath != null) {
      GlobalState.elMenu.value.activePath = state.fullPath!;
    }
    return state.fullPath;
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return LayoutPage(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(routes: [elementRoutes]),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.material,
              builder: (context, state) => const MaterialPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.cupertino,
              builder: (context, state) => const CupertinoPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class Routes {
  static const String home = '/';
  static const String material = '/material';
  static const String cupertino = '/cupertino';
}
