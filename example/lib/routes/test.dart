import 'package:example/global.dart';
import 'package:example/pages/test/pages/http.dart';

class TestRoutes {
  static const String root = '/test';
}

final testRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: TestRoutes.root,
      builder: (context, state) => const HttpPage(),
    ),
  ],
);
