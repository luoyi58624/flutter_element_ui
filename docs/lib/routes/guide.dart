import 'package:docs/global.dart';

import '../pages/guide/design.dart';

final List<RouteBase> guideRoutes = [
  GoRoute(
      path: '/guide',
      redirect: (context, state) => '/guide/design',
      routes: [
        GoRoute(
          path: 'design',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: DesignPage()),
        )
      ]),
];
