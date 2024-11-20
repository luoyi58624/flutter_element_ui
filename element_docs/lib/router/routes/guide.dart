part of '../router.dart';

List<RouteBase> buildGuideRoutes(String path) {
  return [
    RouterUtil.buildRoute(
      path: '${path}design',
      builder: (context, state) => const DesignPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}nav',
      builder: (context, state) => const NavPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}install',
      builder: (context, state) => const InstallPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}quickstart',
      builder: (context, state) => const QuickStartPage(),
    ),
    GoRoute(
      path: '${path}i18n',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '${path}theme',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: ThemePage(),
      ),
    ),
    GoRoute(
      path: '${path}changelog',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '${path}dev-guide',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '${path}dev-faq',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '${path}commit-examples',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
    GoRoute(
      path: '${path}translation',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: NotFoundPage(),
      ),
    ),
  ];
}
