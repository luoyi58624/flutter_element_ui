import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class MyProgress extends HookWidget {
  const MyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final AnimationController controller = useAnimationController(
      duration: 1000.ms,
    );

    useEffect(() {
      controller.repeat();
      return null;
    }, []);

    return LayoutBuilder(builder: (context, constraints) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AnimatedBuilder(
          animation: controller.view,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(300, 8),
              painter: _LineProgressPainter(
                position: controller.value,
              ),
            );
          },
        ),
      );
    });
  }
}

class _LineProgressPainter extends CustomPainter {
  /// 进度值
  final double position;

  _LineProgressPainter({required this.position});

  @override
  void paint(Canvas canvas, Size $size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, 0, $size.width, $size.height),
      paint..color = Colors.grey.shade300,
    );

    final left = position * $size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(left, 0, left + 100, $size.height),
        const Radius.circular(4),
      ),
      paint..color = Colors.green,
    );
  }

  @override
  bool shouldRepaint(covariant _LineProgressPainter oldDelegate) {
    return true;
  }
}
