import 'package:example/global.dart';
import 'package:example/pages/material/pages/home.dart';

class MterialRoutes {
  static const String root = '/material';
}

final materialRoute = StatefulShellBranch(
  routes: [
    GoRoute(
      path: MterialRoutes.root,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
