import 'dart:async';
import 'dart:math';

import 'package:docs/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      // LinearProgressIndicator(),
      // ...List.generate(
      //   2000,
      //   (index) => const ElProgress.animate(
      //     10,
      //     curve: Curves.easeOutSine,
      //   ),
      //   // (index) => const LinearProgressIndicator(),
      //   // (index) => const _Demo(),
      // ),
      // const _Demo(),
      // const Gap(8),
      // const _Demo2(),
      // const Gap(8),
    ];
  }
}



class _Demo2 extends HookWidget {
  const _Demo2({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(milliseconds: 13000),
    );

    useEffect(() {
      controller.repeat();
      return null;
    }, []);

    return LayoutBuilder(builder: (context, cons) {
      final positionRatioAnimation = Tween(
        begin: -100.0,
        end: cons.maxWidth,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ));
      return AnimatedBuilder(
          animation: controller.view,
          builder: (context, child) {
            return Stack(
              children: [
                Container(
                  height: 10,
                  color: Colors.grey.shade200,
                ),
                Positioned(
                  left: positionRatioAnimation.value,
                  child: Container(
                    width: 100,
                    height: 10,
                    color: Colors.green,
                  ),
                ),
              ],
            );
          });
    });
  }
}

class _Demo extends HookWidget {
  const _Demo({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = useAnimationController(
      duration: const Duration(milliseconds: 13000),
    );

    useEffect(() {
      controller.repeat();
      return null;
    }, []);

    return LayoutBuilder(builder: (context, cons) {
      final positionRatioAnimation = Tween(
        begin: -100.0,
        end: cons.maxWidth,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ));
      return AnimatedBuilder(
          animation: controller.view,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(double.infinity, 10),
              painter: _AnimateProgressPainter(
                position: positionRatioAnimation.value,
              ),
            );
          });
    });
  }
}

class _AnimateProgressPainter extends CustomPainter {
  final double position;

  _AnimateProgressPainter({
    required this.position,
  });

  @override
  void paint(Canvas canvas, Size $size) {
    Paint paint = Paint();

    canvas.drawRect(
      Rect.fromLTRB(0, 0, $size.width, $size.height),
      Paint()..color = Colors.grey.shade200,
    );

    canvas.drawRect(
      Rect.fromLTRB(position, 0, position + 100, 10),
      paint..color = Colors.green,
    );
  }

  @override
  bool shouldRepaint(covariant _AnimateProgressPainter oldDelegate) {
    return true;
  }
}
