part of 'index.dart';

class ElStopPropagation extends InheritedWidget {
  /// 阻止事件冒泡小部件，它会在指针按下时立即触发，如果你希望在其他时间点阻止事件冒泡（例如只阻止 onTap 但不阻止 onTapDown），
  /// 你可以在 onTap 事件中执行 context.stopPropagation() 函数。
  const ElStopPropagation({
    super.key,
    required super.child,
  });

  @override
  bool updateShouldNotify(ElStopPropagation oldWidget) => false;
}

class _ElEventInheritedWidget extends InheritedWidget {
  const _ElEventInheritedWidget({
    required super.child,
    required this.isHover,
    required this.setHoverDepend,
    required this.isTap,
    required this.setTapDepend,
    required this.stopPropagation,
  });

  final bool isHover;
  final ElBoolVoidCallback setHoverDepend;
  final bool isTap;
  final ElBoolVoidCallback setTapDepend;
  final VoidCallback stopPropagation;

  static _ElEventInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElEventInheritedWidget>();

  static bool getHoverStatus(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) result.setHoverDepend(true);
    return result?.isHover ?? false;
  }

  static bool getTapStatus(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) result.setTapDepend(true);
    return result?.isTap ?? false;
  }

  static void _stopPropagation(BuildContext context) {
    context
        .getInheritedWidgetOfExactType<_ElEventInheritedWidget>()
        ?.stopPropagation();
  }

  @override
  bool updateShouldNotify(_ElEventInheritedWidget oldWidget) {
    return isHover != oldWidget.isHover || isTap != oldWidget.isTap;
  }
}
