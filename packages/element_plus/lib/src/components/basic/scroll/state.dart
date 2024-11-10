part of 'index.dart';

class _ElScrollState extends State<ElScroll> {
  /// 惯性移动动画控制器
  late final AnimationController controller =
      AnimationController.unbounded(vsync: vsync)
        ..addListener(animateListener)
        ..addStatusListener(animateStatusListener);

  final GlobalKey _scrollKey = GlobalKey();
  final GlobalKey _viewportKey = GlobalKey();

  late Size scrollSize;
  late Size viewportSize;
  late double maxScrollPixels;

  final _offset = Obs(0.0);

  double get offset => _offset.value;

  set offset(double value) {
    if (value <= 0) {
      _offset.value = 0;
    } else if (value >= maxScrollPixels) {
      _offset.value = maxScrollPixels;
    } else {
      _offset.value = value;
    }
  }

  double oldAnimateValue = 0.0; // 记录旧的动画值，用于计算惯性移动的偏移值

  void animateListener() {
    double details = controller.value - oldAnimateValue;
    if (details == 0.0) return;
    oldAnimateValue = controller.value;
    offset -= details;
    if (details.abs() < 0.1) controller.stop();
  }

  void animateStatusListener(AnimationStatus status) {
    i(status);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nextTick(() {
      scrollSize = _scrollKey.currentContext!.size!;
      viewportSize = _viewportKey.currentContext!.size!;
      maxScrollPixels = viewportSize.height - scrollSize.height;
    });

    Widget result = ObsBuilder(builder: (context) {
      return _ScrollRenderWidget(
        offset: offset,
        child: RepaintBoundary(
          key: _viewportKey,
          child: widget.child,
        ),
      );
    });

    if (PlatformUtil.isDesktop) {
      result = Listener(
        onPointerSignal: (e) {
          if (e is PointerScrollEvent) {
            offset += e.scrollDelta.dy;
          }
        },
        child: result,
      );
    } else {
      result = GestureDetector(
        onVerticalDragDown: (e) {
          oldAnimateValue = 0.0;
          if (controller.status != AnimationStatus.completed) {
            controller.stop();
          }
        },
        onVerticalDragUpdate: (e) {
          offset -= e.delta.dy;
        },
        onVerticalDragEnd: (e) {
          if (e.velocity.pixelsPerSecond.dy.abs() > 0.0 &&
              offset > 0 &&
              offset < maxScrollPixels) {
            FrictionSimulation frictionSim = FrictionSimulation(
              0.135,
              0.0,
              e.velocity.pixelsPerSecond.dy,
            );
            controller.animateWith(frictionSim);
          }
        },
        child: result,
      );
    }

    return Builder(
      key: _scrollKey,
      builder: (context) => result,
    );
  }
}
