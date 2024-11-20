part of '../index.dart';

mixin _LongPressMixin<T extends ElEvent> on _CommonMixin<T> {
  /// 长按开始处理
  void longPressStartHandler(PointerDownEvent e) async {
    if (prop.onLongPress == null) return;
    longPressTimer = setTimeout(() {
      longPressTimer = null;
      isActiveLongPress = true;
      if (prop.feedback) HapticFeedback.mediumImpact();
      prop.onLongPress!();
    }, prop.longPressTimeout);
  }
}
