import 'package:flutter/widgets.dart';

import '../../../global.dart';

class ElCollapseTransition extends StatefulWidget {
  /// Element UI 折叠动画小部件
  const ElCollapseTransition(
    this.value, {
    super.key,
    required this.child,
    this.keepState,
    this.duration,
    this.curve,
    this.axis = Axis.vertical,
    this.alignment = Alignment.topLeft,
  });

  /// 控制小部件展开、折叠状态
  /// * true 展开小部件
  /// * false 折叠小部件
  final bool value;

  /// 折叠的子组件
  final Widget child;

  /// 当子组件被折叠时是否保留状态，默认true
  final bool? keepState;

  /// 折叠动画时间
  final Duration? duration;

  /// 折叠动画曲线
  final Curve? curve;

  /// 折叠方向，默认垂直折叠
  final Axis axis;

  /// 折叠的子组件对齐位置，如果改为水平折叠，你也需要调整对齐参数保证视觉统一
  final Alignment alignment;

  @override
  State<ElCollapseTransition> createState() => _ElCollapseTransitionState();
}

class _ElCollapseTransitionState extends State<ElCollapseTransition>
    with SingleTickerProviderStateMixin {
  late bool show = widget.value;
  late final controller = AnimationController(
    vsync: this,
    duration: widget.duration ?? context.elTheme.collapseStyle.duration,
    value: widget.value ? 1.0 : 0.0,
  );
  late Animation animate = CurvedAnimation(
    parent: controller,
    curve: widget.curve ?? context.elTheme.collapseStyle.curve,
  );

  void listenAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed && show) {
      setState(() {
        show = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    ElUtils.nextTick(() {
      if (!(widget.keepState ?? context.elTheme.collapseStyle.keepState)) {
        controller.addStatusListener(listenAnimationStatus);
      }
    });
  }

  @override
  void didUpdateWidget(covariant ElCollapseTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      controller.duration = widget.duration;
    }
    if (widget.duration == null) {
      controller.duration = context.elTheme.collapseStyle.duration;
    }
    if (widget.curve != oldWidget.curve) {
      animate = CurvedAnimation(
        parent: controller,
        curve: widget.curve ?? context.elTheme.collapseStyle.curve,
      );
    }
    if (widget.keepState != oldWidget.keepState) {
      if (widget.keepState ?? context.elTheme.collapseStyle.keepState) {
        controller.removeStatusListener(listenAnimationStatus);
      } else {
        controller.addStatusListener(listenAnimationStatus);
      }
    }
    if (widget.value != oldWidget.value) {
      if (!show && widget.value) show = true;
      widget.value ? controller.forward() : controller.reverse();
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
        return show
            ? ClipRect(
                child: Align(
                  alignment: widget.alignment,
                  widthFactor:
                      widget.axis == Axis.horizontal ? animate.value : null,
                  heightFactor:
                      widget.axis == Axis.vertical ? animate.value : null,
                  child: child,
                ),
              )
            : const SizedBox();
      },
      child: widget.child,
    );
  }
}
