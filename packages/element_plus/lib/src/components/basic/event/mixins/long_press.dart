import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'common.dart';

mixin LongPressMixin<T extends ElEvent> on CommonMixin<T> {
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
