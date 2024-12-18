part of 'event.dart';

@ElModel.copy()
@ElThemeModel(desc: '事件默认配置')
class ElEventThemeData {
  static const theme = ElEventThemeData();
  static const darkTheme = ElEventThemeData();

  /// 事件主题配置，对于所有使用 [ElEvent] 的小部件，你可以为它们绑定默认事件（悬停、单击、双击、长按、右键...）。
  ///
  /// 合并事件主题数据也同样遵循 Component -> LocalTheme -> GlobalTheme 机制，
  /// 在开发组件时，如果你直接占用了某个事件，那么默认情况下用户是无法通过主题进行绑定的，
  /// 如果需要支持用户通过主题绑定，只需在对应事件逻辑中编写以下代码：
  /// ```dart
  /// ElEventTheme.maybeOf(context)?.onTapDown?.call(e);
  /// ElEventTheme.maybeOf(context)?.onTapUp?.call(e);
  /// ```
  const ElEventThemeData({
    this.disabled,
    this.autofocus,
    this.canRequestFocus,
    this.cancelScope,
    this.prevent,
    this.tapUpDelay,
    this.doubleTapTimeout,
    this.delayTapForDouble,
    this.longPressTimeout,
    this.feedback,
    this.behavior,
    this.cursor,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onDoubleTap,
    this.onLongPress,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerMove,
    this.onPointerPanZoomStart,
    this.onPointerPanZoomUpdate,
    this.onPointerPanZoomEnd,
    this.onPointerSignal,
    this.onCancel,
  });

  /// 是否禁用，默认 false
  final bool? disabled;

  /// 是否自动聚焦，如果在 [FocusScope] 中有多个节点设置为自动聚焦，那么只有第一个元素得到焦点，
  /// 如果有多个 [FocusScope]，那么只有最后一个 [FocusScope] 中的第一个元素得到焦点。
  final bool? autofocus;

  /// 是否允许聚焦，默认 true，如果 [disabled] 为 true，那么会强制禁止聚焦。
  final bool? canRequestFocus;

  /// 触发取消事件偏移范围，默认 20 像素
  final int? cancelScope;

  /// 当注册了 [onSecondaryTap] 时，是否阻止浏览器右键默认行为，默认 true
  final bool? prevent;

  /// 指针抬起延迟时间，作用是让 [hasTap] 状态效果更好，默认 100 毫秒
  final int? tapUpDelay;

  /// 双击触发时间，默认 300 毫秒
  final int? doubleTapTimeout;

  /// 如果存在双击事件，是否延迟 [onTap] 的执行，若触发了双击事件，那么 [onTap] 将不会触发，默认 false
  final bool? delayTapForDouble;

  /// 长按触发时间，默认 500 毫秒
  final int? longPressTimeout;

  /// 是否启用长按反馈，在移动端将会触发轻微震动提示，默认 true
  final bool? feedback;

  /// 命中测试行为，默认：[HitTestBehavior.deferToChild]，这也是 [Listener] 的默认值，
  /// 关于 [HitTestBehavior] 的三个行为，这里简单列举一下：
  /// * [HitTestBehavior.deferToChild] - 命中透明部分事件会被忽略
  /// * [HitTestBehavior.opaque] - 命中透明部分事件也能触发
  /// * [HitTestBehavior.translucent] - 命中透明部分事件也能触发，同时位于元素下面的目标也能接收事件
  ///
  /// 以 Stack 为例，堆叠了两个小部件，下方小部件颜色随机，上方小部件颜色透明，点击重叠区域的行为如下：
  /// * [HitTestBehavior.deferToChild] - 下方小部件触发事件
  /// * [HitTestBehavior.opaque] - 上方小部件触发事件
  /// * [HitTestBehavior.translucent] - 上方、下方小部件同时触发事件，但如果使用 [GestureDetector] 而不是 [Listener]，
  /// 由于存在手势竞技场机制，所以它依然只有上方小部件触发事件
  ///
  /// 在大部分情况下你只需考虑 [HitTestBehavior.opaque]，而不是 [HitTestBehavior.translucent]。
  final HitTestBehavior? behavior;

  /// 鼠标悬停光标样式
  final MouseCursor? cursor;

  /// 鼠标进入事件
  final PointerEnterEventListener? onEnter;

  /// 鼠标离开事件
  final PointerExitEventListener? onExit;

  /// 鼠标悬停事件
  final PointerHoverEventListener? onHover;

  /// 主指针点击事件
  final GestureTapCallback? onTap;

  /// 主指针按下事件
  final GestureTapDownCallback? onTapDown;

  /// 主指针抬起事件，为了更好的点击效果，它存在一点延迟：[tapUpDelay]
  final GestureTapUpCallback? onTapUp;

  /// 次要按钮点击事件，例如：鼠标右键
  final GestureTapCallback? onSecondaryTap;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;

  /// 双击事件
  final VoidCallback? onDoubleTap;

  /// 长按事件
  final VoidCallback? onLongPress;

  /// [Listener] 指针按下事件
  final PointerDownEventListener? onPointerDown;

  /// [Listener] 指针抬起事件
  final PointerUpEventListener? onPointerUp;

  /// [Listener] 指针移动事件
  final PointerMoveEventListener? onPointerMove;

  final PointerPanZoomStartEventListener? onPointerPanZoomStart;

  final PointerPanZoomUpdateEventListener? onPointerPanZoomUpdate;

  final PointerPanZoomEndEventListener? onPointerPanZoomEnd;

  /// [Listener] 指针信号事件，作用：监听鼠标滚轮滚动
  final PointerSignalEventListener? onPointerSignal;

  /// 针取消事件，当指针按下时，如果指针移动超出 [cancelScope] 范围、或者离开了元素本身，将执行此回调，
  /// 但是，如果已经触发了长按事件、或者监听了指针移动事件（包括拖拽），那么此回调不会触发。
  final VoidCallback? onCancel;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
