import 'package:example/global.dart';
import 'package:example/routes/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/layout.dart';
import 'pages/home/home.dart';
import 'routes/cupertino.dart';
import 'routes/element.dart';
import 'routes/test.dart';

final router = GoRouter(
  navigatorKey: $el.navigatorKey,
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
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        elementRoute,
        materialRoute,
        cupertinoRoute,
        testRoute,
      ],
    ),
  ],
);
