import 'package:docs/routes/guide.dart';

import 'global.dart';
import 'layout/layout.dart';
import 'pages/home.dart';

final router = GoRouter(
  navigatorKey: $el.navigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => LayoutPage(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        ...guideRoutes,
      ],
    ),
  ],
);
