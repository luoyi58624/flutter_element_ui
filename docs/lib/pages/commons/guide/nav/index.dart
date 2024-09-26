import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      Container(
        width: 300,
        height: 20,
        child: HoverBuilder(builder: (context) {
          return Center(
              child: _Demo(
            size: context.isHover ? 20 : 6,
          ));
        }),
      ),
    ];
  }
}

class _Demo extends StatefulWidget {
  const _Demo({super.key, required this.size});

  final double size;

  @override
  State<_Demo> createState() => _DemoState();
}

class _DemoState extends State<_Demo> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late CurvedAnimation curve = CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  );
  late Animation<double> sizeAnimate;

  @override
  void initState() {
    super.initState();
    sizeAnimate = Tween(
      begin: widget.size,
      end: widget.size,
    ).animate(curve);
  }

  @override
  void didUpdateWidget(covariant _Demo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.size != oldWidget.size) {
      sizeAnimate = Tween(
        begin: sizeAnimate.value,
        end: widget.size,
      ).animate(curve);
      controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller.view,
        builder: (context, child) {
          return Container(
            width: 300,
            height: sizeAnimate.value,
            color: Colors.red,
          );
        });
  }
}
