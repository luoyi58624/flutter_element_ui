part of '../index.dart';

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

// /// 阻止后代组件获得焦点，应用场景：当使用 [ElFocusScope] 时，希望排除某些小部件获取焦点
// class ElStopFocus extends InheritedWidget {
//   const ElStopFocus({
//     super.key,
//     required super.child,
//     this.enabled = true,
//   });
//
//   /// 一个便捷开关，是否启用此功能，默认 true
//   final bool enabled;
//
//   static bool _of(BuildContext context) =>
//       context.dependOnInheritedWidgetOfExactType<ElStopFocus>()?.enabled ??
//       false;
//
//   @override
//   bool updateShouldNotify(ElStopFocus oldWidget) =>
//       enabled != oldWidget.enabled;
// }

// ===========================================================================
// ================== 下面都是私有的配置类，用户无需关注 ========================
// ===========================================================================
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

class _FocusScopeInheritedWidget extends InheritedWidget {
  const _FocusScopeInheritedWidget(
    this.poinerDownFocusNode,
    this.setPoinerDownFocusNode, {
    required super.child,
  });

  final FocusNode? poinerDownFocusNode;
  final void Function(FocusNode? node) setPoinerDownFocusNode;

  @override
  bool updateShouldNotify(_FocusScopeInheritedWidget oldWidget) => false;
}
