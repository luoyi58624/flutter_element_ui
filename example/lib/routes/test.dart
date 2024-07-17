import 'package:example/global.dart';
import 'package:example/pages/test/home.dart';

class TestRoutes {
  static const String root = '/test';
}

final testRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: TestRoutes.root,
      builder: (context, state) => const TestHomePage(),
    ),
  ],
);
