part of 'index.dart';

class _ElScrollState extends State<ElScroll> {
  /// 惯性移动动画控制器
  late final AnimationController controller =
      AnimationController.unbounded(vsync: vsync)..addListener(animateListener);
  double offset = 0;

  double? oldAnimateValue; // 记录旧的动画值，用于计算惯性移动的偏移值

  void animateListener() {
    late double details;
    if (oldAnimateValue == null) {
      oldAnimateValue = controller.value;
      details = controller.value;
    } else {
      details = controller.value - oldAnimateValue!;
      oldAnimateValue = controller.value;
    }
    setState(() {
      offset += details;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (e) {
        if (e is PointerScrollEvent) {
          setState(() {
            offset -= e.scrollDelta.dy;
          });
        }
      },
      child: GestureDetector(
        onVerticalDragDown: (e) {
          oldAnimateValue = null;
          if (controller.status != AnimationStatus.completed) {
            controller.stop();
          }
        },
        onVerticalDragUpdate: (e) {
          setState(() {
            offset += e.delta.dy;
          });
        },
        onVerticalDragEnd: (e) {
          FrictionSimulation frictionSim = FrictionSimulation(
            0.135,
            0.0,
            e.velocity.pixelsPerSecond.dy,
          );
          controller.animateWith(frictionSim);
        },
        child: _Scroll(
          offset: offset,
          child: RepaintBoundary(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
