import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/global.dart';

class ElCollapseTransition extends HookWidget {
  /// Element UI 折叠动画小部件
  const ElCollapseTransition(
    this.value, {
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.axis = Axis.vertical,
    this.alignment = Alignment.topLeft,
  });

  /// 控制小部件展开、折叠状态
  /// * true 展开小部件
  /// * false 折叠小部件
  final bool value;

  /// 折叠的子组件
  final Widget child;

  /// 折叠动画时间
  final Duration duration;

  /// 折叠动画曲线
  final Curve curve;

  /// 折叠方向，默认垂直折叠
  final Axis axis;

  /// 折叠的子组件对齐位置，如果改为水平折叠，你也需要调整对齐参数保证视觉统一
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: duration,
      initialValue: value ? 1.0 : 0.0,
    );
    final animate = CurvedAnimation(parent: controller, curve: curve);
    value ? controller.forward() : controller.reverse();
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
