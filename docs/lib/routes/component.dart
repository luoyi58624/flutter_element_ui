import 'package:docs/global.dart';
import 'package:docs/pages/commons/not_found.dart';

import '../pages/commons/component/basic/button/button.dart';
import '../pages/commons/component/basic/text/text.dart';
import '../pages/commons/component/data/collapse.dart';
import '../pages/commons/component/feedback/message/message.dart';
import '../pages/commons/overview/cupertino/cupertino.dart';
import '../pages/commons/overview/element/element.dart';
import '../pages/commons/overview/material/material.dart';

List<RouteBase> buildComponentRoutes(String path) {
  return [
    RouterUtil.buildRoute(
      path: '${path}element',
      builder: (context, state) => const ElementOverviewPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}material',
      builder: (context, state) => const MaterialOverviewPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}cupertino',
      builder: (context, state) => const CupertinoOverviewPage(),
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
      path: '${path}collapse',
      builder: (context, state) => const CollapsePage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}message',
      builder: (context, state) => const MessagePage(),
    ),
  ];
}
