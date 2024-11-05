import 'package:flutter/widgets.dart';

class ElEventBubble extends StatefulWidget {
  const ElEventBubble({super.key});

  @override
  State<ElEventBubble> createState() => ElEventBubbleState();
}

class ElEventBubbleState extends State<ElEventBubble> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ElStopPropagation extends InheritedWidget {
  /// 阻止 Element UI 部分小部件事件冒泡
  const ElStopPropagation({
    super.key,
    required super.child,
  });

  /// 从当前上下文获取 [ElStopPropagation] 实例，并以 [ElStopPropagation] 实例所在 Element Tree 的位置执行阻止冒泡函数，
  /// 通常情况下此函数由支持事件冒泡的小部件调用，并不需要用户执行它
  static void of(
    BuildContext context,
    void Function(BuildContext context) stopPropagation,
  ) {
    final result =
        context.getElementForInheritedWidgetOfExactType<ElStopPropagation>();
    if (result != null) stopPropagation(result);
  }

  @override
  bool updateShouldNotify(ElStopPropagation oldWidget) => false;
}
