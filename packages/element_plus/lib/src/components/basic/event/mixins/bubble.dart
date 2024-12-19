part of '../event.dart';

mixin _BubbleMixin<T extends ElEvent> on _CommonMixin<T> {
  /// 冒泡标识，如果此标识变成 false，意味着后代组件阻止了事件冒泡
  bool bubbleFlag = true;

  /// 阻止事件冒泡，它会一层一层向上不断执行，直到最顶层的 [ElEvent]，
  /// 逻辑很简单，就是将 [bubbleFlag] 冒泡标识设置为 false，阻止事件的执行。
  void stopPropagation() {
    if (bubbleFlag) {
      bubbleFlag = false;
      _EventInheritedWidget.stopPropagation(context);
    }
  }

  /// 重置事件冒泡，指针抬起时会自动重置冒泡标识，但如果不是通过事件触发的函数，
  /// 而是隐式调用函数阻止事件冒泡，那么你必须手动执行重置冒泡，否则上层事件将不再触发。
  void resetPropagation() {
    bubbleFlag = true;
    _EventInheritedWidget.resetPropagation(context);
  }

  // /// 根据 [ElStopPropagation] 尝试阻止事件冒泡，此方法会以 [ElStopPropagation]
  // /// 所在 Element Tree 的位置开始，向上查找 [ElEvent] 小部件并执行阻止冒泡函数
  // void stopPropagationByWidget() {
  //   final result = context.getInheritedWidgetOfExactType<ElStopPropagation>();
  //   if (result != null && result.enabled == true) {
  //     context
  //         .getElementForInheritedWidgetOfExactType<ElStopPropagation>()
  //         ?.stopPropagation();
  //   }
  // }

  /// 重置 [ElBubbleBuilder] 小部件的状态，当 [onPointerUp]、[onPointerCancel] 时触发
  void resetBubbleBuilderWidget() {
    if (_BubbleInheritedWidget.triggerFlag) {
      _BubbleInheritedWidget.triggerFlag = false;
      _BubbleInheritedWidget._updateBubbleFlag(context, false);
    }
  }
}
