import 'package:docs/pages/commons/not_found.dart';

import '../global.dart';

final GoRouter router = GoRouter.routingConfig(
  navigatorKey: el.navigatorKey,
  initialLocation: '/',
  errorPageBuilder: (context, state) => const NoTransitionPage(
    child: NotFoundPage(),
  ),
  routingConfig: RouterState.routingConfig,
);
