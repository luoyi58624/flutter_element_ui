part of 'index.dart';

class _ElEventInheritedWidget extends InheritedWidget {
  const _ElEventInheritedWidget({
    required super.child,
    required this.isHover,
    required this.setHoverDepend,
    required this.isTap,
    required this.setTapDepend,
  });

  final bool isHover;
  final ElBoolVoidCallback setHoverDepend;
  final bool isTap;
  final ElBoolVoidCallback setTapDepend;

  static _ElEventInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElEventInheritedWidget>();

  static bool getHoverStatus(BuildContext context) {
    final result = maybeOf(context);
    // 绑定依赖，当悬停时会自动重建小部件
    if (result != null) result.setHoverDepend(true);
    return result?.isHover ?? false;
  }

  static bool getTapStatus(BuildContext context) {
    final result = maybeOf(context);
    // 绑定依赖，当点击时会自动重建小部件
    if (result != null) result.setTapDepend(true);
    return result?.isTap ?? false;
  }

  @override
  bool updateShouldNotify(_ElEventInheritedWidget oldWidget) {
    return isHover != oldWidget.isHover || isTap != oldWidget.isTap;
  }
}
