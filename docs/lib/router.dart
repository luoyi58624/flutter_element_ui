import 'package:docs/pages/not_found.dart';
import 'package:docs/routes/guide.dart';
import 'package:flutter/widgets.dart';

import 'global.dart';
import 'layout/layout.dart';
import 'pages/home.dart';
import 'routes/component.dart';

final GoRouter router = GoRouter.routingConfig(
  navigatorKey: el.navigatorKey,
  initialLocation: '/',
  errorPageBuilder: (context, state) => const NoTransitionPage(
    child: NotFoundPage(),
  ),
  routingConfig: routingConfig,
);

/// 动态路由配置
final routingConfig = ValueNotifier<RoutingConfig>(
  desktopRoutingConfig,
);

final desktopRoutingConfig = RoutingConfig(
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
            componentRoute,
          ],
        ),
      ],
    ),
  ],
);

final mobileRoutingConfig = RoutingConfig(
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
          const NoTransitionPage(child: DemoPage()),
          routes: [
            guideRoute,
            componentRoute,
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

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const H1('测试');
  }
}

