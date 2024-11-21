part of '../router.dart';

List<RouteBase> buildTemplateRoutes(String path) {
  return [
    RouterUtil.buildRoute(
      path: '${path}simple',
      builder: (context, state) => const SimpleLayoutPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}material',
      builder: (context, state) => const MaterialLayoutPage(),
    ),
  ];
}
