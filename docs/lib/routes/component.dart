import 'package:docs/global.dart';
import 'package:docs/pages/commons/not_found.dart';

import '../pages/commons/component/basic/button/button.dart';
import '../pages/commons/component/basic/text/text.dart';
import '../pages/commons/component/feedback/message/message.dart';
import '../pages/commons/component/overview/overview.dart';
import '../pages/desktop/component_layout.dart';

const String _path = 'component';

final RouteBase componentRoute = ShellRoute(
  pageBuilder: (context, state, child) => NoTransitionPage(
    child: ComponentLayoutPage(child: child),
  ),
  routes: [
    GoRoute(
      path: '$_path/overview',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: OverviewPage(),
      ),
    ),
    GoRoute(
      path: '$_path/button',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: ButtonPage(),
      ),
    ),
    GoRoute(
      path: '$_path/color',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/icon',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/layout',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/link',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/text',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: TextPage(),
      ),
    ),
    GoRoute(
      path: '$_path/scrollbar',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/typography',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '$_path/message',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: MessagePage(),
      ),
    ),
  ],
);
