part of '../router.dart';

List<RouteBase> buildTemplateRoutes() {
  return [
    RouterUtil.buildRoute(
      path: 'layout',
      builder: (context, state) => const LayoutTemplatePage(),
    ),
  ];
}
