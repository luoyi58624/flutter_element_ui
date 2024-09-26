part of '../index.dart';

class _LineProgressInheritedWidget extends InheritedWidget {
  const _LineProgressInheritedWidget(
    this.vertical, {
    required super.child,
  });

  final bool vertical;

  static _LineProgressInheritedWidget of(BuildContext context) {
    final _LineProgressInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_LineProgressInheritedWidget>();
    assert(result != null, 'No _LineProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_LineProgressInheritedWidget oldWidget) =>
      vertical != oldWidget.vertical;
}

/// 默认的直线进度条
class _LineProgress extends HookWidget {
  const _LineProgress();

  @override
  Widget build(BuildContext context) {
    final $data = _ProgressInheritedWidget.of(context);
    final $lineData = _LineProgressInheritedWidget.of(context);

    final AnimationController controller = useAnimationController(
      duration: const Duration(milliseconds: 200),
    );
    CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    );

    final tween = Tween(begin: -$data.physicalSize, end: $data.physicalSize);
    final positionAnimation = tween.animate(curvedAnimation);
    final paintSize = Size(double.infinity, $data.size);
    final progressSize = $data.physicalSize * $data.ratio;
    return ClipRRect(
      borderRadius: BorderRadius.circular($data.radius),
      child: AnimatedBuilder(
          animation: controller.view,
          builder: (context, child) {
            return CustomPaint(
              size: paintSize,
              painter: _ProgressPainter(
                bgColor: $data.bgColor,
                color: $data.color,
                width: progressSize,
                left: positionAnimation.value,
                radius: $data.radius,
              ),
            );
          }),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final Color bgColor;
  final Color color;
  final double width;
  final double left;
  final double radius;

  _ProgressPainter({
    required this.bgColor,
    required this.color,
    required this.width,
    required this.left,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
      paint..color = bgColor,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(left, 0, left + width, size.height),
        Radius.circular(radius),
      ),
      paint..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
