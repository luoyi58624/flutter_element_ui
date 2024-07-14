import 'package:example/global.dart';
import 'package:example/pages/components/basic/font.dart';
import 'package:example/pages/components/data/badge.dart';
import 'package:example/pages/components/feedback/dialog.dart';
import 'package:example/pages/components/form/input.dart';
import 'package:example/pages/components/form/radio.dart';
import 'package:example/pages/components/form/switch.dart';
import 'package:example/pages/components/layout/basic.dart';
import 'package:example/pages/components/layout/overlay.dart';
import 'package:example/pages/element/layout/layout.dart';

import '../../pages/components/basic/button.dart';
import '../../pages/components/basic/color.dart';
import '../../pages/components/basic/text.dart';
import '../../pages/components/data/table.dart';
import '../../pages/components/form/form.dart';
import '../pages/element/home.dart';
import '../../pages/test/border.dart';
import '../../pages/test/image_list.dart';

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

final elementRoutes = StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) =>
      ElementLayoutPage(navigationShell),
  branches: [
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: ElementRoutes.root,
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
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: '$_tests/image_list',
          builder: (context, state) => const ImageListPage(),
        ),
      ],
    ),
  ],
);
