part of '../index.dart';

/// 直线进度条
class _LineProgress extends StatefulWidget {
  const _LineProgress({
    required this.value,
    required this.size,
    required this.color,
    required this.vertical,
  });

  final double value;
  final double size;
  final Color color;
  final bool vertical;

  @override
  State<_LineProgress> createState() => _LineProgressState();
}

class _LineProgressState extends State<_LineProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late CurvedAnimation curve = CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  );
  late Animation<double> sizeAnimate;
  late Animation<Color?> colorAnimate;
  bool _execAnimate = false;

  late double _progressValue;

  void setProgressValue(double value) {
    Tween(
      begin: _progressValue,
      end: value,
    ).animate(curve);
    controller.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _progressValue = widget.value;
    sizeAnimate = Tween(
      begin: widget.size,
      end: widget.size,
    ).animate(curve);
    colorAnimate = ColorTween(
      begin: widget.color,
      end: widget.color,
    ).animate(curve);
  }

  @override
  void didUpdateWidget(covariant _LineProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.size != oldWidget.size) {
      sizeAnimate = Tween(
        begin: sizeAnimate.value,
        end: widget.size,
      ).animate(curve);
      _execAnimate = true;
    }
    if (widget.color != oldWidget.color) {
      colorAnimate = ColorTween(
        begin: colorAnimate.value,
        end: widget.color,
      ).animate(curve);
      _execAnimate = true;
    }
    if (_execAnimate) {
      _execAnimate = false;
      controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final $data = _ProgressInheritedWidget.of(context);
    // el.i(valueAnimate.value);
    return AnimatedBuilder(
        animation: controller.view,
        builder: (context, child) {
          double $radius = $data.round ? sizeAnimate.value / 2 : $data.radius;
          return ClipRRect(
            borderRadius: BorderRadius.circular($radius),
            child: CustomPaint(
              size: Size($data.physicalSize.width, sizeAnimate.value),
              painter: _LineProgressPainter(
                value: $data.physicalSize.width * widget.value,
                size: sizeAnimate.value,
                position: 0,
                radius: $radius,
                vertical: widget.vertical,
                bgColor: $data.bgColor,
                color: colorAnimate.value!,
              ),
            ),
          );
        });
  }
}

class _LineProgressPainter extends CustomPainter {
  /// 进度值
  final double value;

  /// 进度条大小
  final double size;

  /// 进度条偏移位置
  final double position;
  final double radius;
  final bool vertical;
  final Color bgColor;
  final Color color;

  _LineProgressPainter({
    required this.value,
    required this.size,
    required this.position,
    required this.radius,
    required this.vertical,
    required this.bgColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size $size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, 0, $size.width, $size.height),
      paint..color = bgColor,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(position, 0, position + value, $size.height),
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
