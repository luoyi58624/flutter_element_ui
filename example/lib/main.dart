import 'package:flutter/material.dart';

import 'global.dart';

void main() async {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: buildApp(),
    );
  }

  Widget buildApp() {
    return WidgetsApp.router(
      color: const Color(0xffffffff),
      routerConfig: router,
      builder: (context, child) => ElConfigProvider(
        config: ElConfigData(radius: 4),
        child: child!,
      ),
    );
  }
}
