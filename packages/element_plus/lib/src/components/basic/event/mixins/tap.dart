part of '../index.dart';

mixin _TapMixin<T extends ElEvent> on _CommonMixin<T> {
  /// 是否存在点击状态依赖
  bool hasTapDepend = false;

  final _isTap = BaseObs(false);

  /// 点击状态响应式变量，此属性会注入到 InheritedWidget 小部件
  bool get isTap => _isTap.value;

  set isTap(bool value) {
    if (hasTapDepend) _isTap.value = value;
  }

  void setTapDepend() {
    hasTapDepend = true;
  }

  /// onTapUp 触发需要延迟 100 毫秒触发，这样可以让点击事件的效果更好，
  /// 否则，当指针轻触屏幕时，onTapDown -> onTapUp 之间的点击时间极短，
  /// 如果 [Widget] 依赖 isTap 状态，那么效果就是一闪而过。
  Timer? _tapUpTimer;

  void _cancelTapUpTimer() {
    if (_tapUpTimer != null) {
      _tapUpTimer!.cancel();
      _tapUpTimer = null;
    }
  }

  void tapDownHandler(PointerDownEvent e) {
    if (pointType == kPrimaryButton) {
      _cancelTapUpTimer();
      isTap = true;
      prop.onTapDown?.call(e.toDetails);
    }
  }

  void tapUpHandler(PointerUpEvent e) {
    if (pointType == kPrimaryButton) {
      _tapHandler();
      // 延迟更新 isTap 的状态
      _tapUpTimer = setTimeout(() {
        _tapUpTimer = null;
        if (mounted) {
          isTap = false;
          prop.onTapUp?.call(e.toDetails);
        }
      }, max(prop.tapUpDelay - (currentMilliseconds - tapDownTime), 0));
    }
  }

  /// 决定 onTap 触发逻辑
  void _tapHandler() {
    if (isCancel) return;
    // 如果设置了等待双击延迟，需要判断双击计时器是否开始、或者是否已经触发了双击，若为 true 那么禁止执行单击事件
    if (prop.delayTapForDouble &&
        (doubleTapTimer != null || isActiveDoubleTap)) {
      return;
    }
    // 如果没有注册长按事件，那么直接触发单击事件
    if (prop.onLongPress == null) {
      onTap();
    } else {
      // 如果指针抬起时没有达到长按阈值时间，那么也将触发点击事件，同时还需要取消长按计时器
      if (isActiveLongPress == false) {
        onTap();
        cancelLongPressTimer();
      }
    }
  }
}
