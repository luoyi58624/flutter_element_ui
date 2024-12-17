part of '../event.dart';

mixin _DoubleTapMixin<T extends ElEvent> on _CommonMixin<T>, _TapMixin<T> {
  /// 双击事件处理，当第一次指针抬起时，如果用户注册了双击事件，
  /// 那么会启动一个计时器，如果用户在指定时间内再次点击，那么将触发双击事件。
  void doubleTapHandler(PointerUpEvent e) {
    if (prop.onDoubleTap == null) return;
    if (isActiveLongPress) return; // 若触发了长按则直接返回
    if (doubleTapTimer != null) {
      doubleTapTimer!.cancel();
      doubleTapTimer = null;
      isActiveDoubleTap = true;
      prop.onDoubleTap!();
    } else {
      doubleTapTimer = setTimeout(() {
        doubleTapTimer = null;
        // 双击计时器到了销毁时间，如果设置了等待双击延迟，那么触发点击事件
        if (prop.delayTapForDouble) {
          if (isCancel == false) onTap();
        }
      }, prop.doubleTapTimeout);
    }
  }
}
