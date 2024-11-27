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
    this.pointerDownFocusNode,
    this.setPointerDownFocusNode, {
    required super.child,
  });

  final FocusNode? pointerDownFocusNode;
  final void Function(FocusNode? node) setPointerDownFocusNode;

  @override
  bool updateShouldNotify(_FocusScopeInheritedWidget oldWidget) => false;
}

/// 每当 [ElEvent] 找到 [ElFocusScope] 时，都会插入这个小部件将 [_FocusScopeInheritedWidget] 进行隔离，
/// 防止嵌套的 [ElEvent] 重复创建 [Focus] 焦点，这个小部件原理参照 [LookupBoundary]，
/// 之所以要单独创建是为了防止影响到 [Overlay.of]
class _FocusScopeLookupBoundary extends InheritedWidget {
  const _FocusScopeLookupBoundary({
    required super.child,
  });

  /// 通过上下文寻找 [_FocusScopeInheritedWidget]，如果找到表示祖先存在 [ElFocusScope] 小部件，
  /// 此函数时间复杂度为 O(1)
  static _FocusScopeInheritedWidget? getWidget(BuildContext context) {
    final result = context
        .getElementForInheritedWidgetOfExactType<_FocusScopeInheritedWidget>();
    if (result == null) return null;
    final boundaryResult = context
        .getElementForInheritedWidgetOfExactType<_FocusScopeLookupBoundary>();
    if (boundaryResult != null && boundaryResult.depth > result.depth) {
      return null;
    }
    return result.widget as _FocusScopeInheritedWidget;
  }

  @override
  bool updateShouldNotify(_FocusScopeLookupBoundary oldWidget) => false;
}
