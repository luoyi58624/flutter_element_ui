import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'common.dart';

mixin LongPressMixin<T extends ElEvent> on CommonMixin<T> {
  /// 长按开始处理
  void longPressStartHander(PointerDownEvent e) async {
    // 尝试注册长按事件计时器，需要限制鼠标指针，只能长按鼠标左键
    if (prop.onLongPress != null) _longPressHandler();
  }

  /// 长按事件处理，此函数会在 [onPointerDown] 指针按下时执行
  void _longPressHandler() {
    longPressTimer = setTimeout(() {
      longPressTimer = null;
      isActiveLongPress = true;
      if (prop.feedback) HapticFeedback.mediumImpact();
      prop.onLongPress!();
    }, prop.longPressTimeout);
  }
}
