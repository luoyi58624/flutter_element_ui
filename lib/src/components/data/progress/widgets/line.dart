part of '../index.dart';

/// 直线进度条
class _LineProgress extends StatefulWidget {
  const _LineProgress({
    required this.ratio,
    required this.size,
    required this.color,
    required this.axis,
    required this.duration,
    required this.curve,
  });

  final double ratio;
  final Size size;
  final Color color;
  final AxisDirection axis;
  final Duration duration;
  final Curve curve;

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
  late Animation<Size?> sizeAnimate;
  late Animation<Color?> colorAnimate;

  /// 进度条更新比例动画控制器
  late AnimationController ratioController = AnimationController(
    vsync: this,
    duration: widget.duration,
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
    curve: widget.curve,
  );
  late Animation<double> ratioAnimate;

  bool _execAnimate = false;
  bool _execRatioAnimate = false;

  @override
  void initState() {
    super.initState();
    sizeAnimate = SizeTween(
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
    if (widget.duration != oldWidget.duration) {
      ratioController.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      ratioCurve = CurvedAnimation(
        parent: ratioController,
        curve: widget.curve,
      );
      ratioAnimate = Tween(
        begin: ratioAnimate.value,
        end: widget.ratio,
      ).animate(ratioCurve);
    }
    if (widget.size != oldWidget.size) {
      sizeAnimate = Tween(
        // 如果是更改进度条方向引起的尺寸变化，那么不能应用动画，因为进度条尺寸约束为无限大，
        // 虽然 LayoutBuilder 可以解决此问题，但它会导致重绘溢出问题，性能会降低 50%
        begin: widget.axis == oldWidget.axis ? sizeAnimate.value : widget.size,
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
          double $radius = $data.round
              ? ($data.vertical
                      ? sizeAnimate.value!.width
                      : sizeAnimate.value!.height) /
                  2
              : $data.radius;

          return ClipRRect(
            borderRadius: BorderRadius.circular($radius),
            child: AnimatedBuilder(
                animation: ratioController.view,
                builder: (context, child) {
                  return CustomPaint(
                    size: sizeAnimate.value!,
                    painter: _LineProgressPainter(
                      ratio: ratioAnimate.value,
                      positionRatio: 0,
                      radius: $radius,
                      axis: widget.axis,
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

  /// 进度条偏移位置比例
  final double positionRatio;

  final double radius;
  final AxisDirection axis;
  final Color bgColor;
  final Color color;

  _LineProgressPainter({
    required this.ratio,
    required this.positionRatio,
    required this.radius,
    required this.axis,
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

    late double $position;

    late double l;
    late double t;
    late double r;
    late double b;
    switch (axis) {
      case AxisDirection.right:
        $position = $size.width * positionRatio;
        l = $position;
        t = 0;
        r = $position + ratio * $size.width;
        b = $size.height;
        break;
      case AxisDirection.up:
        $position = $size.height * positionRatio;
        l = 0;
        t = $size.height - ($position + ratio * $size.height);
        r = $size.width;
        b = $size.height - $position;
        break;
      case AxisDirection.down:
        $position = $size.height * positionRatio;
        l = 0;
        t = $position;
        r = $size.width;
        b = $position + ratio * $size.height;
        break;
      case AxisDirection.left:
        $position = $size.width * positionRatio;
        l = $size.width - ($position + ratio * $size.width);
        t = 0;
        r = $size.width - $position;
        b = $size.height;
        break;
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(l, t, r, b),
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
