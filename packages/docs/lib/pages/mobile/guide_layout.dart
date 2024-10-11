import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import '../../router/router_config.dart';

class MobileGuideLayout extends StatelessWidget {
  const MobileGuideLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('指南'),
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
      body: ColumnWidget(
        scroll: true,
        children: SlideRouterConfig.guideSlideRoutes
            .map((e) => CardWidget(
                  title: e.$1,
                  elevation: 1,
                  children: e.$2
                      .map((e) => CellWidget(
                            title: e.$1,
                            onTap: () {
                              context.go(e.$2);
                            },
                          ))
                      .toList(),
                ))
            .toList(),
      ),
    );
  }
}
