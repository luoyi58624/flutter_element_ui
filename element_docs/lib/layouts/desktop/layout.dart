import 'package:flutter/material.dart';

import '../../pages/layout_header.dart';
import '../../pages/setting.dart';
import '../../router/router_config.dart';
import 'slide.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LayoutHeader(),
        elevation: 1,
        scrolledUnderElevation: 1,
        actions: const [
          SizedBox.shrink(),
        ],
      ),
      endDrawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: const GlobalSetting(),
      ),
      body: child,
    );
  }
}

class DesktopGuideLayout extends StatelessWidget {
  const DesktopGuideLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SlideWidget(SlideRouterConfig.guideSlideRoutes),
        Expanded(child: child),
      ],
    );
  }
}

class DesktopComponentLayout extends StatelessWidget {
  const DesktopComponentLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SlideWidget(SlideRouterConfig.componentSlideRoutes),
        Expanded(child: child),
      ],
    );
  }
}

class DesktopTemplateLayout extends StatelessWidget {
  const DesktopTemplateLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SlideWidget(SlideRouterConfig.templateSlideRoutes),
        Expanded(child: child),
      ],
    );
    // List<({String name, String path})> list = [
    //   (name: 'ElLayout 布局', path: '/${RootRoute.template.$2}/layout'),
    // ];
    // return GridWidget(
    //   size: 150,
    //   itemCount: list.length,
    //   itemBuilder: (context, index) => Card(
    //     clipBehavior: Clip.hardEdge,
    //     child: InkWell(
    //       onTap: () {
    //         context.go(list[index].path);
    //       },
    //       child: Center(
    //         child: ElText(
    //           list[index].name,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
