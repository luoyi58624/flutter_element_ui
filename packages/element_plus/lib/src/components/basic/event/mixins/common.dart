part of '../index.dart';

/// 各种类型事件的通用属性 mixin
mixin _CommonMixin<T extends ElEvent> on State<T> {
  GlobalKey childKey = GlobalKey();

  /// 最终合并的属性配置
  late _Prop prop;

  /// 冒泡标识，如果此标识变成 false，意味着后代组件阻止了事件冒泡
  bool bubbleFlag = true;

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

  /// 长按事件计时器
  Timer? longPressTimer;

  /// 焦点组节点对象，如果使用 [ElFocusScope]，那么它将初始化
  FocusScopeNode? focusScopeNode;

  /// 如果存在 [Focus] 焦点小部件，那么它将被初始化
  FocusNode focusNode = FocusNode();

  /// 指针按下时是否禁止设置焦点，此属性由 [ElStopFocus] 小部件决定
  bool disabledSetFocusNode = false;

  /// 保存 [ElFocusScope] 小部件实例，用于设置指针按下时的焦点
  _FocusScopeInheritedWidget? _focusScopeWidget;

  set focusScopeWidget(_FocusScopeInheritedWidget? value) {
    if (value != null) {
      _focusScopeWidget = value;
      focusScopeNode = FocusScope.of(context, createDependency: false);
    } else {
      _focusScopeWidget = null;
      focusScopeNode = null;
    }
  }

  void cancelLongPressTimer() {
    if (longPressTimer != null) {
      longPressTimer!.cancel();
      longPressTimer = null;
    }
  }

  void onTap() {
    _requestFocus();
    prop.onTap?.call();
  }

  void _requestFocus() {
    if (disabledSetFocusNode == false) {
      if (_focusScopeWidget != null && focusScopeNode!.hasFocus == false) {
        if (focusNode.canRequestFocus) focusNode.requestFocus();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }
}
