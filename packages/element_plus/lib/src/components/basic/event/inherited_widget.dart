part of 'index.dart';

class ElStopPropagation extends InheritedWidget {
  /// 阻止事件冒泡小部件
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
    required this.resetPropagation,
  });

  final bool isHover;
  final ElBoolVoidCallback setHoverDepend;
  final bool isTap;
  final ElBoolVoidCallback setTapDepend;
  final VoidCallback stopPropagation;
  final VoidCallback resetPropagation;

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
    final result =
        context.getInheritedWidgetOfExactType<_ElEventInheritedWidget>();
    if (result != null) result.stopPropagation();
  }

  static void _resetPropagation(BuildContext context) {
    final result =
        context.getInheritedWidgetOfExactType<_ElEventInheritedWidget>();
    if (result != null) result.resetPropagation();
  }

  @override
  bool updateShouldNotify(_ElEventInheritedWidget oldWidget) {
    return isHover != oldWidget.isHover || isTap != oldWidget.isTap;
  }
}
