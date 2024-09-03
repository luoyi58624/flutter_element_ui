import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/global.dart';

import '../../../widgets/model_value.dart';

class ElCollapse2 extends HookWidget {
  const ElCollapse2({
    super.key,
    required this.value,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
    this.axis = Axis.vertical,
    this.alignment = Alignment.center,
  });

  /// 是否展开
  final bool value;

  /// 支持任意子组件
  final Widget child;

  /// 动画时间
  final Duration duration;

  /// 动画曲线
  final Curve curve;

  /// 折叠方向，默认垂直折叠，可选水平折叠
  final Axis axis;

  /// 子组件对齐位置，默认居中
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: duration,
      initialValue: value ? 1.0 : 0.0,
    );
    final animate = CurvedAnimation(parent: controller, curve: curve);
    useEffect(() {
      value ? controller.forward() : controller.reverse();
      return null;
    }, [value]);
    return AnimatedBuilder(
      animation: controller.view,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: alignment,
            widthFactor: axis == Axis.horizontal ? animate.value : null,
            heightFactor: axis == Axis.vertical ? animate.value : null,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class ElCollapse extends ElModelValue<bool> {
  /// Element UI 折叠小部件基础实现
  const ElCollapse(
    super.modelValue, {
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
    this.axis = Axis.vertical,
    this.alignment = Alignment.center,
    super.onChanged,
  });

  /// 支持任意子组件
  final Widget child;

  /// 动画时间
  final Duration duration;

  /// 动画曲线
  final Curve curve;

  /// 折叠方向，默认垂直折叠，可选水平折叠
  final Axis axis;

  /// 子组件对齐位置，默认居中
  final Alignment alignment;

  @override
  State<ElCollapse> createState() => _ElCollapseState();
}

class _ElCollapseState extends ElModelValueState<ElCollapse, bool>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.duration,
    value: modelValue ? 1.0 : 0.0,
  );

  late Animation animate = CurvedAnimation(
    parent: controller,
    curve: widget.curve,
  );

  @override
  void didUpdateWidget(covariant ElCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      controller.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      animate = CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      );
    }
  }

  @override
  Widget builder(BuildContext context, value) {
    value ? controller.forward() : controller.reverse();

    return AnimatedBuilder(
      animation: controller.view,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: widget.alignment,
            widthFactor: widget.axis == Axis.horizontal ? animate.value : null,
            heightFactor: widget.axis == Axis.vertical ? animate.value : null,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
