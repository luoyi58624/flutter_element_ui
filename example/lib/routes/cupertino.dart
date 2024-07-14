import 'package:example/global.dart';
import 'package:example/pages/cupertino/home.dart';

class CupertinoRoutes {
  static const String root = '/cupertino';
}

final cupertinoRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: CupertinoRoutes.root,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
