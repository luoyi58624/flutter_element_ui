import 'package:flutter/widgets.dart';

class EventInheritedWidget extends InheritedWidget {
  const EventInheritedWidget(
    this.isHover,
    this.setHoverDepend,
    this.isTap,
    this.setTapDepend,
    this._stopPropagation, {
    super.key,
    required super.child,
  });

  final bool isHover;
  final VoidCallback setHoverDepend;
  final bool isTap;
  final VoidCallback setTapDepend;
  final VoidCallback _stopPropagation;

  static EventInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<EventInheritedWidget>();

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
        .getInheritedWidgetOfExactType<EventInheritedWidget>()
        ?._stopPropagation();
  }

  @override
  bool updateShouldNotify(EventInheritedWidget oldWidget) {
    return isHover != oldWidget.isHover || isTap != oldWidget.isTap;
  }
}
