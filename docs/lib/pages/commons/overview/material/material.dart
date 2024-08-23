import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/01.dart';
import 'examples/02.dart';
import 'examples/03.dart';

class MaterialOverviewPage extends StatelessWidget {
  const MaterialOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaterialPage 组件总览'),
        actions: [
          ObsBuilder(builder: (context) {
            return Switch(
              value: GlobalState.isDark,
              onChanged: (v) => GlobalState.isDark = v,
            );
          }),
        ],
      ),
      body: const ColumnWidget(
        scroll: true,
        repaintBoundary: true,
        padding: EdgeInsets.all(8),
        children: [
          Example1(),
          Example2(),
          Example3(),
        ],
      ),
    );
  }
}
