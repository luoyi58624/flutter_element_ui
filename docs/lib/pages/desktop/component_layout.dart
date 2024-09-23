import 'package:flutter/widgets.dart';

import '../../router/router_config.dart';
import 'slide.dart';

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
