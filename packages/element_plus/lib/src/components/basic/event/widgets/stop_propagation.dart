part of '../event.dart';

/// 阻止事件冒泡小部件，它会在指针按下时立即触发，另一种方式是手动执行 context.stopPropagation()
class ElStopPropagation extends InheritedWidget {
  const ElStopPropagation({
    super.key,
    required super.child,
    this.enabled = true,
  });

  /// 一个便捷开关，是否启用此功能，默认 true
  final bool enabled;

  @override
  bool updateShouldNotify(ElStopPropagation oldWidget) =>
      enabled != oldWidget.enabled;
}
