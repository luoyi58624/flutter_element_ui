import 'package:flutter/widgets.dart';

import '../../router/router_config.dart';
import 'slide.dart';

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
