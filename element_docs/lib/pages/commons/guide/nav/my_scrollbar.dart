import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';

class MyScrollbar extends StatefulWidget {
  const MyScrollbar({super.key, required this.child, required this.controller});

  final ScrollController controller;
  final Widget child;

  @override
  State<MyScrollbar> createState() => _MyScrollbarState();
}

class _MyScrollbarState extends State<MyScrollbar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation animation;
  late ScrollbarPainter scrollbarPainter;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: 200.ms,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    scrollbarPainter.dispose();
  }

  void updateScrollbar() {
    scrollbarPainter = ScrollbarPainter(
      color: const Color(0x66BCBCBC),
      fadeoutOpacityAnimation: animation,
      textDirection: TextDirection.ltr,
      minLength: 50.0,
      ignorePointer: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    updateScrollbar();
    return NotificationListener<ScrollNotification>(
      onNotification: (e) {
        scrollbarPainter.update(e.metrics, AxisDirection.down);
        return false;
      },
      child: CustomPaint(
        foregroundPainter: scrollbarPainter,
        child: RepaintBoundary(child: widget.child),
      ),
    );
  }
}
