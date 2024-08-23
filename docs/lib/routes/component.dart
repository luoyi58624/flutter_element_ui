import 'package:docs/global.dart';
import 'package:docs/pages/commons/not_found.dart';

import '../pages/commons/component/basic/button/button.dart';
import '../pages/commons/component/basic/text/text.dart';
import '../pages/commons/component/feedback/message/message.dart';
import '../pages/commons/component/overview/overview.dart';
import '../pages/commons/cupertino/cupertino.dart';
import '../pages/commons/material/material.dart';

List<RouteBase> buildComponentRoutes(String path) {
  return [
    RouterUtil.buildRoute(
      path: '${path}overview',
      builder: (context, state) => const OverviewPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}material',
      builder: (context, state) => const MaterialPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}cupertino',
      builder: (context, state) => const CupertinoPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}button',
      builder: (context, state) => const ButtonPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}color',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}icon',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}layout',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}link',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}text',
      builder: (context, state) => const TextPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}scrollbar',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}typography',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}message',
      builder: (context, state) => const MessagePage(),
    ),
  ];
}

