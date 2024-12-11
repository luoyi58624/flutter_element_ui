part of '../router.dart';

List<RouteBase> _buildComponentRoutes(String path) {
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
      path: '${path}layout',
      builder: (context, state) => const LayoutPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}event',
      builder: (context, state) => const EventPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}focus',
      builder: (context, state) => const FocusPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}button',
      builder: (context, state) => const ButtonPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}button2',
      builder: (context, state) => const ButtonPage2(),
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
      path: '${path}scrollbar',
      builder: (context, state) => const ScrollbarPage(),
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
      path: '${path}tag',
      builder: (context, state) => const TagPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}tree',
      builder: (context, state) => const TreePage(),
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
      path: '${path}table',
      builder: (context, state) => const TablePage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}animated_size',
      builder: (context, state) => const AnimatedSizePage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}context_menu',
      builder: (context, state) => const ContextMenuPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}drag',
      builder: (context, state) => const DragPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}ring',
      builder: (context, state) => const RingPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}split_resizer',
      builder: (context, state) => const SplitResizerPage(),
    ),
    RouterUtil.buildRoute(
      path: '${path}split_pane',
      builder: (context, state) => const SplitPanePage(),
    ),
  ];
}
