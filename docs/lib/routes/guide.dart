import 'package:docs/global.dart';
import 'package:docs/pages/not_found.dart';

import '../layout/guide_layout.dart';
import '../pages/guide/design.dart';
import '../pages/guide/nav.dart';

const String _path = 'guide';

final RouteBase guideRoute = ShellRoute(
  pageBuilder: (context, state, child) => NoTransitionPage(
    child: GuideLayoutPage(child: child),
  ),
  routes: [
    GoRoute(
      path: '$_path/design',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: DesignPage(),
      ),
    ),
    GoRoute(
      path: '$_path/nav',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NavPage(),
      ),
    ),
    GoRoute(
      path: '$_path/install',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/quickstart',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/i18n',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/theme',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/changelog',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/dev-guide',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/dev-faq',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/commit-examples',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/translation',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
  ],
);
