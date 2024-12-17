part of '../event.dart';

mixin _LongPressMixin<T extends ElEvent> on _CommonMixin<T> {
  /// 长按事件计时器
  Timer? longPressTimer;

  void cancelLongPressTimer() {
    if (longPressTimer != null) {
      longPressTimer!.cancel();
      longPressTimer = null;
    }
  }

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
