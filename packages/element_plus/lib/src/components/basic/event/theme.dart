part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '事件默认配置')
class ElEventThemeData {
  static const theme = ElEventThemeData();
  static const darkTheme = ElEventThemeData();

  const ElEventThemeData({
    this.disabled,
    this.cancelScope,
    this.prevent,
    this.doubleTapTimeout,
    this.delayTapForDouble,
    this.longPressTimeout,
    this.feedback,
    this.triggerDragScope,
    this.hitTestBehavior,
    this.cursor,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
    this.onContextMenu,
    this.onDoubleTap,
    this.onLongPress,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerCancel,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onPointerSignal,
  });

  /// 是否禁用，默认 false
  final bool? disabled;

  /// 触发取消事件偏移范围，默认 10 像素
  final int? cancelScope;

  /// 如果 [onContextMenu] 不为空，是否阻止浏览器右键默认行为，默认 true
  final bool? prevent;

  /// 双击触发时间，默认 300 毫秒
  final int? doubleTapTimeout;

  /// 如果存在双击事件，是否延迟 [onTap] 的执行，若触发了双击事件，那么 [onTap] 将不会触发，默认 false
  final bool? delayTapForDouble;

  /// 长按触发时间，默认 500 毫秒
  final int? longPressTimeout;

  /// 是否启用长按反馈，在移动端将会触发轻微震动提示，默认 true
  final bool? feedback;

  /// 触发拖拽事件的偏移幅度，在桌面端设置一定的偏移幅度可以防止意外地触发拖拽行为，默认 0
  final int? triggerDragScope;

  /// 命中测试行为，默认：[HitTestBehavior.deferToChild]
  final HitTestBehavior? hitTestBehavior;

  /// 鼠标悬停光标样式
  final MouseCursor? cursor;

  /// 鼠标进入事件
  final PointerEnterEventListener? onEnter;

  /// 鼠标离开事件
  final PointerExitEventListener? onExit;

  /// 鼠标悬停事件
  final PointerHoverEventListener? onHover;

  /// 点击事件
  final VoidCallback? onTap;

  /// 右键事件
  final VoidCallback? onContextMenu;

  /// 双击事件
  final VoidCallback? onDoubleTap;

  /// 长按事件
  final VoidCallback? onLongPress;

  /// 指针按下事件，回调参数是原始指针对象，你可以通过 e.toDetails 转成 [TapDownDetails]
  final PointerDownEventListener? onPointerDown;

  /// 指针抬起事件，回调参数是原始指针对象，你可以通过 e.toDetails 转成 [TapUpDetails]
  final PointerUpEventListener? onPointerUp;

  /// 指针取消事件，当指针按下时，如果指针移动超出 [cancelScope] 范围、或者离开了元素本身，将执行此回调
  final VoidCallback? onPointerCancel;

  /// 拖拽开始事件，它受 [triggerDragScope] 属性影响
  final GestureDragStartCallback? onDragStart;

  /// 拖拽更新事件
  final GestureDragUpdateCallback? onDragUpdate;

  /// 拖拽结束事件
  final GestureDragEndCallback? onDragEnd;

  /// 垂直拖拽开始事件，它受 [triggerDragScope] 属性影响
  final GestureDragStartCallback? onVerticalDragStart;

  /// 垂直拖拽更新事件
  final GestureDragUpdateCallback? onVerticalDragUpdate;

  /// 垂直拖拽结束事件
  final GestureDragEndCallback? onVerticalDragEnd;

  /// 水平拖拽开始事件，它受 [triggerDragScope] 属性影响
  final GestureDragStartCallback? onHorizontalDragStart;

  /// 水平拖拽更新事件
  final GestureDragUpdateCallback? onHorizontalDragUpdate;

  /// 水平拖拽结束事件
  final GestureDragEndCallback? onHorizontalDragEnd;

  /// 指针信号事件，例如：鼠标滚轮滚动
  final PointerSignalEventListener? onPointerSignal;
}
