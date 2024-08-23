import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/slide.dart';

class DesktopComponentLayout extends StatelessWidget {
  const DesktopComponentLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SlideWidget(RouterUtil.componentSlideRoutes),
        Expanded(child: child),
      ],
    );
  }
}
