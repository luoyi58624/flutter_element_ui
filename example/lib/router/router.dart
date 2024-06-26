import 'package:example/global.dart';
import 'package:flutter/widgets.dart';

import 'routes/layout_routes.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    if (state.fullPath != null)
      GlobalState.elMenu.value.activePath = state.fullPath!;
    return state.fullPath;
  },
  routes: [
    // ShellRoute(
    //   builder: (context, state, navigationShell) => LayoutPage(navigationShell: navigationShell),
    //   routes: [
    //     GoRoute(
    //       path: '/',
    //       builder: (context, state) => const HomePage(),
    //     ),
    //     GoRoute(
    //       path: '/components',
    //       builder: (context, state) => const ComponentsPage(),
    //     ),
    //   ],
    // ),
    layoutRoutes,
  ],
);
