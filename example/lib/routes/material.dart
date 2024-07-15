import 'package:example/global.dart';
import 'package:example/pages/material/pages/home.dart';

class MaterialRoutes {
  static const String root = '/material';
}

final materialRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: MaterialRoutes.root,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
