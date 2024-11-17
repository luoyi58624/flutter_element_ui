import 'dart:async';

import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../prop.dart';

/// 各种类型事件的通用属性 mixin
mixin CommonMixin<T extends ElEvent> on State<T> {
  GlobalKey childKey = GlobalKey();

  /// 最终合并的属性配置
  late EventProp prop;

  /// 冒泡标识，如果此标识变成 false，意味着后代组件阻止了事件冒泡
  bool bubbleFlag = true;

  /// 子组件的尺寸
  Size childSize = Size.zero;

  /// 指针按下时的类型，例如：鼠标左键 = 1，右键 = 2，中键 = 3
  int pointType = kPrimaryButton;

  /// 指针按下位置（全局坐标系）
  Offset tapDownOffset = Offset.zero;

  /// 记录当前的按下时间
  late int tapDownTime;

  /// 是否触发了取消事件
  bool isCancel = false;

  /// 是否激活了双击
  bool isActiveDoubleTap = false;

  /// 是否激活了长按
  bool isActiveLongPress = false;

  /// 双击事件计时器
  Timer? doubleTapTimer;

  /// 长按事件计时器
  Timer? longPressTimer;

  void cancelLongPressTimer() {
    if (longPressTimer != null) {
      longPressTimer!.cancel();
      longPressTimer = null;
    }
  }
}
