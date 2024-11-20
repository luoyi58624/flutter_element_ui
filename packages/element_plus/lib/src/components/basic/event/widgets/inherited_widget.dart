part of '../index.dart';

class ElStopPropagation extends InheritedWidget {
  /// 阻止事件冒泡小部件，它会在指针按下时立即触发，另一种方式是手动执行 context.stopPropagation()
  const ElStopPropagation({
    super.key,
    required super.child,
    this.enabled = true,
  });

  /// 是否启用阻止冒泡，默认 true
  final bool enabled;

  @override
  bool updateShouldNotify(ElStopPropagation oldWidget) => false;
}

class _EventInheritedWidget extends InheritedWidget {
  const _EventInheritedWidget(
    this.isHover,
    this.setHoverDepend,
    this.isTap,
    this.setTapDepend,
    this._stopPropagation,
    this._resetPropagation, {
    required super.child,
  });

  final bool isHover;
  final VoidCallback setHoverDepend;
  final bool isTap;
  final VoidCallback setTapDepend;
  final VoidCallback _stopPropagation;
  final VoidCallback _resetPropagation;

  static _EventInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_EventInheritedWidget>();

  static bool getHoverStatus(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) result.setHoverDepend();
    return result?.isHover ?? false;
  }

  static bool getTapStatus(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) result.setTapDepend();
    return result?.isTap ?? false;
  }

  static void stopPropagation(BuildContext context) {
    context
        .getInheritedWidgetOfExactType<_EventInheritedWidget>()
        ?._stopPropagation();
  }

  static void resetPropagation(BuildContext context) {
    context
        .getInheritedWidgetOfExactType<_EventInheritedWidget>()
        ?._resetPropagation();
  }

  @override
  bool updateShouldNotify(_EventInheritedWidget oldWidget) {
    return isHover != oldWidget.isHover || isTap != oldWidget.isTap;
  }
}

class _BubbleInheritedWidget extends InheritedWidget {
  const _BubbleInheritedWidget({
    required super.child,
    required this.flag,
    required this.updateBubbleFlag,
  });

  final bool? flag;
  final ElBoolVoidCallback updateBubbleFlag;

  /// 执行 stopPropagation 时会寻找是否存在 [_BubbleInheritedWidget] 小部件，
  /// 如果存在，那么会将此标识符设置为 true，当指针释放时根据此标识重置状态。
  static bool triggerFlag = false;

  static bool? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_BubbleInheritedWidget>()
      ?.flag;

  static _BubbleInheritedWidget? getWidget(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_BubbleInheritedWidget>();

  static void _updateBubbleFlag(BuildContext context, bool value,
      [_BubbleInheritedWidget? widget]) {
    (widget ?? getWidget(context))?.updateBubbleFlag(value);
  }

  @override
  bool updateShouldNotify(_BubbleInheritedWidget oldWidget) =>
      flag != oldWidget.flag;
}

class _FocusInheritedWidget extends InheritedWidget {
  const _FocusInheritedWidget(
    this.focusNode,
    this.isFocus,
    this.isFocusVisible,
    this.setFocusDepend,
    this.setFocusVisibleDepend,
    this.setFocusForEvent, {
    required super.child,
  });

  final FocusNode focusNode;
  final bool isFocus;
  final bool isFocusVisible;
  final VoidCallback setFocusDepend;
  final VoidCallback setFocusVisibleDepend;
  final VoidCallback setFocusForEvent;

  static _FocusInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_FocusInheritedWidget>();

  static bool getFocusStatus(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) result.setFocusDepend();
    return result?.isFocus ?? false;
  }

  static bool getFocusVisibleStatus(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) result.setFocusVisibleDepend();
    return result?.isFocusVisible ?? false;
  }

  @override
  bool updateShouldNotify(_FocusInheritedWidget oldWidget) {
    return isFocus != oldWidget.isFocus;
  }
}
