import 'package:docs/pages/not_found.dart';
import 'package:docs/routes/guide.dart';
import 'package:flutter/widgets.dart';

import 'global.dart';
import 'layout/layout.dart';
import 'pages/home.dart';

final router = GoRouter(
  navigatorKey: el.navigatorKey,
  initialLocation: '/',
  errorPageBuilder: (context, state) => const NoTransitionPage(
    child: NotFoundPage(),
  ),
  redirect: (BuildContext context, GoRouterState state) {
    if (state.fullPath != null) {
      RouterUtil.currentPath.value = state.fullPath!;
    }
    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) => LayoutPage(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
          routes: [
            guideRoute,
          ],
        ),
      ],
    ),
  ],
);

class RouterUtil {
  RouterUtil._();

  static final currentPath = Obs('');
}
