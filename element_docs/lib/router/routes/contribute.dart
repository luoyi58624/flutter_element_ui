part of '../router.dart';

List<RouteBase> buildContributeRoutes(String path) {
  return [
    RouterUtil.buildRoute(
      path: '${path}start',
      builder: (context, state) => const MaterialLayoutPage(),
    ),
  ];
}
