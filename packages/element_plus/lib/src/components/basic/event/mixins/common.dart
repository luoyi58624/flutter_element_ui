part of '../index.dart';

/// 各种类型事件的通用属性 mixin
mixin _CommonMixin<T extends ElEvent> on State<T> {
  GlobalKey childKey = GlobalKey();

  /// 最终合并的属性配置
  late _Prop prop;

  /// 子组件的尺寸
  Size childSize = Size.zero;

  /// 指针按下时的类型，例如：鼠标左键 = 1，右键 = 2，中键 = 3
  int pointType = kPrimaryButton;

  /// 指针按下位置（全局坐标系）
  Offset tapDownOffset = Offset.zero;

  /// 记录当前的按下时间
  int tapDownTime = currentMilliseconds;

  /// 是否触发了取消事件
  bool isCancel = false;

  /// 是否激活了双击
  bool isActiveDoubleTap = false;

  /// 是否激活了长按
  bool isActiveLongPress = false;

  /// 双击事件计时器
  Timer? doubleTapTimer;

  /// 设置指针按下时的一些通用属性
  setPointerDownDetails(PointerDownEvent e) {
    childSize = childKey.currentContext?.size ?? Size.zero;
    pointType = e.buttons;
    tapDownOffset = e.position;
    tapDownTime = currentMilliseconds;
    isCancel = false;
  }
}
