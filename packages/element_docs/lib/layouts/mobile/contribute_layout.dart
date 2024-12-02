import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../../router/router_config.dart';

class MobileContributeLayout extends StatelessWidget {
  const MobileContributeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('贡献'),
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
      body: ColumnWidget(
        scroll: true,
        repaintBoundary: true,
        children: SlideRouterConfig.contributeSlideRoutes
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
