import 'package:example/global.dart';
import 'package:example/pages/element/pages/form/slider.dart';

import '../../pages/element/pages/data/table.dart';
import '../../pages/element/pages/form/form.dart';
import '../pages/element/layout/layout.dart';
import '../pages/element/pages/data/badge.dart';
import '../pages/element/pages/data/collapse.dart';
import '../pages/element/pages/data/image.dart';
import '../pages/element/pages/feedback/dialog.dart';
import '../pages/element/pages/feedback/drawer.dart';
import '../pages/element/pages/feedback/message.dart';
import '../pages/element/pages/feedback/toast.dart';
import '../pages/element/pages/feedback/tooltip.dart';
import '../pages/element/pages/form/input.dart';
import '../pages/element/pages/form/input_number.dart';
import '../pages/element/pages/form/radio.dart';
import '../pages/element/pages/layout/basic.dart';
import '../pages/element/pages/layout/overlay.dart';
import '../pages/element/pages/navigation/menu.dart';
import '../pages/element/pages/navigation/tabs.dart';

class ElementRoutes {
  static const String root = '/element';
  static const String layout = '$root/layout';
  static const String basic = '$root/basic';
  static const String form = '$root/form';
  static const String data = '$root/data';
  static const String navigation = '$root/navigation';
  static const String feedBack = '$root/feedback';
}

final elementRoute = StatefulShellBranch(routes: [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        ElementLayoutPage(navigationShell),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.layout}/basic',
            builder: (context, state) => const LayoutBasicPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.layout}/drag',
            builder: (context, state) => const OverlayPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.form}/input',
            builder: (context, state) => const InputPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.form}/input_number',
            builder: (context, state) => const InputNumberPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.form}/radio',
            builder: (context, state) => const RadioPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.form}/slider',
            builder: (context, state) => const SliderPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.form}/form',
            builder: (context, state) => const FormPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.data}/badge',
            builder: (context, state) => const BadgePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.data}/image',
            builder: (context, state) => const ImagePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.data}/table',
            builder: (context, state) => const TablePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.data}/collapse',
            builder: (context, state) => const CollapsePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.navigation}/menu',
            builder: (context, state) => const MenuPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.navigation}/tabs',
            builder: (context, state) => const TabsPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.feedBack}/dialog',
            builder: (context, state) => const DialogPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.feedBack}/drawer',
            builder: (context, state) => const DrawerPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.feedBack}/message',
            builder: (context, state) => const MessagePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.feedBack}/toast',
            builder: (context, state) => const ToastPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '${ElementRoutes.feedBack}/tooltip',
            builder: (context, state) => const TooltipPage(),
          ),
        ],
      ),
    ],
  ),
]);
