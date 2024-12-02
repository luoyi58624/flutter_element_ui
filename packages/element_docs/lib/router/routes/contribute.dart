part of '../router.dart';

List<RouteBase> buildContributeRoutes(String path) {
  return [
    RouterUtil.buildRoute(
      path: '${path}start',
      builder: (context, state) => const ContributeStartPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}theme_manager',
      builder: (context, state) => const ThemeManagerPage(),
    ),
  ];
}
