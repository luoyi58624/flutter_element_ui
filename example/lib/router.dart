import 'package:example/layout/layout.dart';
import 'package:example/pages/test/border.dart';
import 'package:example/state.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'pages/components/index.dart';
import 'pages/home.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    if (state.fullPath != null) GlobalState.activePath.value = state.fullPath!;
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
    StatefulShellRoute.indexedStack(
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
              path: '/components',
              builder: (context, state) => const ComponentsPage(),
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
    ),
  ],
);