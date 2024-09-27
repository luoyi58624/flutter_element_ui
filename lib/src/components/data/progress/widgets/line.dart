part of '../index.dart';

/// 直线进度条
class _LineProgress extends StatefulWidget {
  const _LineProgress({
    required this.ratio,
    required this.size,
    required this.color,
    required this.vertical,
    required this.disabledAnimate,
  });

  final double ratio;
  final double size;
  final Color color;
  final bool vertical;
  final bool disabledAnimate;

  @override
  State<_LineProgress> createState() => _LineProgressState();
}

class _LineProgressState extends State<_LineProgress>
    with TickerProviderStateMixin {
  /// 进度条外观动画控制器
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

  /// 进度条更新比例动画控制器
  late AnimationController ratioController = AnimationController(
    vsync: this,
    duration: widget.disabledAnimate ? Duration.zero : _valueDuration,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ratioAnimate = Tween(
          begin: widget.ratio,
          end: widget.ratio,
        ).animate(ratioCurve);
      }
    });
  late CurvedAnimation ratioCurve = CurvedAnimation(
    parent: ratioController,
    curve: const Cubic(0.4, 0, 0.2, 1),
  );
  late Animation<double> ratioAnimate;

  bool _execAnimate = false;
  bool _execRatioAnimate = false;

  @override
  void initState() {
    super.initState();
    sizeAnimate = Tween(
      begin: widget.size,
      end: widget.size,
    ).animate(curve);
    colorAnimate = ColorTween(
      begin: widget.color,
      end: widget.color,
    ).animate(curve);
    ratioAnimate = Tween(
      begin: widget.ratio,
      end: widget.ratio,
    ).animate(ratioCurve);
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
    if (widget.ratio != oldWidget.ratio) {
      ratioAnimate = Tween(
        begin: ratioAnimate.value,
        end: widget.ratio,
      ).animate(ratioCurve);
      _execRatioAnimate = true;
    }
    if (widget.disabledAnimate != oldWidget.disabledAnimate) {
      if (widget.disabledAnimate) {
        ratioController.duration = Duration.zero;
      } else {
        ratioController.duration = _valueDuration;
      }
    }
    if (_execAnimate) {
      _execAnimate = false;
      controller.forward(from: 0);
    }
    if (_execRatioAnimate) {
      _execRatioAnimate = false;
      ratioController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    controller.dispose;
    ratioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final $data = _ProgressInheritedWidget.of(context);
    return AnimatedBuilder(
        animation: controller.view,
        builder: (context, child) {
          double $radius = $data.round ? sizeAnimate.value / 2 : $data.radius;
          return ClipRRect(
            borderRadius: BorderRadius.circular($radius),
            child: AnimatedBuilder(
                animation: ratioController.view,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size($data.physicalSize.width, sizeAnimate.value),
                    painter: _LineProgressPainter(
                      ratio: ratioAnimate.value,
                      position: 0,
                      size: sizeAnimate.value,
                      radius: $radius,
                      vertical: widget.vertical,
                      bgColor: $data.bgColor,
                      color: colorAnimate.value!,
                    ),
                  );
                }),
          );
        });
  }
}

class _LineProgressPainter extends CustomPainter {
  /// 进度条比值
  final double ratio;

  /// 进度条偏移位置
  final double position;

  /// 进度条大小
  final double size;

  final double radius;
  final bool vertical;
  final Color bgColor;
  final Color color;

  _LineProgressPainter({
    required this.ratio,
    required this.position,
    required this.size,
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
    final $position = $size.width * position;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
            $position, 0, $position + ratio * $size.width, $size.height),
        Radius.circular(radius),
      ),
      paint..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant _LineProgressPainter oldDelegate) {
    return true;
  }
}
