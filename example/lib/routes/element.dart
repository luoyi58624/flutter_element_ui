import 'package:example/global.dart';
import 'package:example/pages/element/pages/form/slider.dart';

import '../../pages/element/pages/basic/button.dart';
import '../../pages/element/pages/basic/color.dart';
import '../../pages/element/pages/basic/text.dart';
import '../../pages/element/pages/data/table.dart';
import '../../pages/element/pages/form/form.dart';
import '../pages/element/home.dart';
import '../pages/element/layout/layout.dart';
import '../pages/element/pages/basic/font.dart';
import '../pages/element/pages/data/badge.dart';
import '../pages/element/pages/data/image.dart';
import '../pages/element/pages/feedback/dialog.dart';
import '../pages/element/pages/form/input.dart';
import '../pages/element/pages/form/radio.dart';
import '../pages/element/pages/form/switch.dart';
import '../pages/element/pages/layout/basic.dart';
import '../pages/element/pages/layout/overlay.dart';
import '../pages/element/test/border.dart';

class ElementRoutes {
  static const String root = '/element';
  static const String component = '$root/components';
  static const String componentLayout = '$component/layout';
  static const String componentBasic = '$component/basic';
  static const String componentForm = '$component/form';
  static const String componentData = '$component/data';
  static const String componentFeedBack = '$component/feedback';
}

const String _tests = '/tests';

final elementRoute = StatefulShellBranch(routes: [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        ElementLayoutPage(navigationShell),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.root}/home',
            builder: (context, state) => const HomePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentLayout}/basic',
            builder: (context, state) => const LayoutBasicPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentLayout}/drag',
            builder: (context, state) => const OverlayPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentBasic}/button',
            builder: (context, state) => const ButtonPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentBasic}/text',
            builder: (context, state) => const TextPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentBasic}/color',
            builder: (context, state) => const ColorPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentBasic}/font',
            builder: (context, state) => const FontPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentForm}/input',
            builder: (context, state) => const InputPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentForm}/radio',
            builder: (context, state) => const RadioPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentForm}/switch',
            builder: (context, state) => const SwitchPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentForm}/slider',
            builder: (context, state) => const SliderPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentForm}/form',
            builder: (context, state) => const FormPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentData}/badge',
            builder: (context, state) => const BadgePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentData}/image',
            builder: (context, state) => const ImagePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentData}/table',
            builder: (context, state) => const TablePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.componentFeedBack}/dialog',
            builder: (context, state) => const DialogPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '$_tests/border',
            builder: (context, state) => const BorderTestPage(),
          ),
        ],
      ),
    ],
  ),
]);
