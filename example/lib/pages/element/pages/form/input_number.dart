import 'package:example/global.dart';
import 'package:flutter/material.dart';

class InputNumberPage extends StatelessWidget {
  const InputNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Center(child: ElInputNumber());
    return Center(
      child: Column(
        children: [
          const Gap(50),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     ...AxisDirection.values.map(
          //       (e) => ElTriangle(
          //         size: const Size(100, 100),
          //         direction: e,
          //       ),
          //     )
          //   ],
          // ),
          // const ElTriangle(size: Size(100, 100),radius: 20,),
          RepaintBoundary(
            child: CustomPaint(
              size: const Size(300, 300),
              painter: _MyPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    canvas.drawLine(Offset.zero, const Offset(100, 0), paint);
    // canvas.drawLine(const Offset(100, 0), const Offset(100, 100), paint);
    // canvas.drawLine(const Offset(100, 100), const Offset(0, 100), paint);
    // canvas.drawLine(const Offset(0, 100), const Offset(0, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
