import 'package:element_docs/global.dart';

import '../../pages/commons/component/basic/button/index.dart';
import '../../pages/commons/component/basic/button_group/index.dart';
import '../../pages/commons/component/basic/color/index.dart';
import '../../pages/commons/component/basic/icon/index.dart';
import '../../pages/commons/component/basic/text/index.dart';
import '../../pages/commons/component/data/collapse/index.dart';
import '../../pages/commons/component/data/progress/index.dart';
import '../../pages/commons/component/feedback/message/index.dart';
import '../../pages/commons/component/feedback/toast/index.dart';
import '../../pages/commons/component/form/input/index.dart';
import '../../pages/commons/component/form/slider/index.dart';
import '../../pages/commons/component/form/switch/index.dart';
import '../../pages/commons/component/navigation/nav_menu/index.dart';
import '../../pages/commons/component/navigation/tabs/index.dart';
import '../../pages/commons/component/other/animated_size/index.dart';
import '../../pages/commons/component/other/context_menu/index.dart';
import '../../pages/commons/not_found.dart';
import '../../pages/commons/overview/cupertino/index.dart';
import '../../pages/commons/overview/element/index.dart';
import '../../pages/commons/overview/material/index.dart';
import '../../widgets/demo.dart';
import '../router_util.dart';

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
      path: '${path}button_group',
      builder: (context, state) => const ButtonGroupPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}color',
      builder: (context, state) => const ColorPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}icon',
      builder: (context, state) => const IconPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}layout',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}text',
      builder: (context, state) => const TextPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}typography',
      builder: (context, state) => const ExampleSmoothScroll(),
    ),
    RouterUtil.buildRoute(
      path: '${path}autocomplete',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}cascader',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}checkbox',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}color-picker',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}date-picker',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}datetime-picker',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}form',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}input',
      builder: (context, state) => const InputPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}input-number',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}radio',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}rate',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}select',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}slider',
      builder: (context, state) => const SliderPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}switch',
      builder: (context, state) => const SwitchPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}time-picker',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}time-select',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}transfer',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}tree-select',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}upload',
      builder: (context, state) => const NotFoundPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}collapse',
      builder: (context, state) => const CollapsePage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}progress',
      builder: (context, state) => const ProgressPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}message',
      builder: (context, state) => const MessagePage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}toast',
      builder: (context, state) => const ToastPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}nav_menu',
      builder: (context, state) => const NavMenuPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}tabs',
      builder: (context, state) => const TabsPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}animated_size',
      builder: (context, state) => const AnimatedSizePage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}context_menu',
      builder: (context, state) => const ContextMenuPage(),
    ),
  ];
}
