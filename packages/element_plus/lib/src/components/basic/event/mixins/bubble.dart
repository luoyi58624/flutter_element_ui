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

  /// 重置 [ElBubbleBuilder] 小部件的状态，当 [onPointerUp]、[onPointerCancel] 时触发
  void resetBubbleBuilderWidget() {
    if (_BubbleInheritedWidget.triggerFlag) {
      _BubbleInheritedWidget.triggerFlag = false;
      _BubbleInheritedWidget._updateBubbleFlag(context, false);
    }
  }
}
