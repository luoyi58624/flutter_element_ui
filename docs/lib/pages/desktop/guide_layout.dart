import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/slide.dart';

class DesktopGuideLayout extends StatelessWidget {
  const DesktopGuideLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SlideWidget(RouterUtil.guideSlideRoutes),
        Expanded(child: child),
      ],
    );
  }
}
