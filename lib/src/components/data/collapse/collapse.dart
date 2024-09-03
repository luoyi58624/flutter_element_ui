import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/global.dart';

class ElCollapse extends HookWidget {
  /// Element UI 实现的最基础折叠小部件，它只有一个作用，以动画形式控制小部件的展开、折叠
  const ElCollapse(
    this.value, {
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
    this.axis = Axis.vertical,
    this.alignment = Alignment.topCenter,
  });

  /// 控制小部件展开、折叠状态
  /// * true 展开小部件
  /// * false 折叠小部件
  final bool value;

  /// 支持任意子组件
  final Widget child;

  /// 动画时间
  final Duration duration;

  /// 动画曲线
  final Curve curve;

  /// 折叠方向，默认垂直折叠
  final Axis axis;

  /// 子组件对齐位置，默认顶部居中
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
