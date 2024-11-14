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
    this.hitTestBehavior,
    this.cursor,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
    this.onContextMenu,
    this.onDoubleTap,
    this.onLongPress,
    this.onDown,
    this.onUp,
    this.onCancel,
    this.onMove,
    this.onMoveEnd,
    this.onVerticalMove,
    this.onVerticalMoveEnd,
    this.onHorizontalMove,
    this.onHorizontalMoveEnd,
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
  final PointerDownEventListener? onDown;

  /// 指针抬起事件，回调参数是原始指针对象，你可以通过 e.toDetails 转成 [TapUpDetails]
  final PointerUpEventListener? onUp;

  /// 指针取消事件，当指针按下时，如果指针移动超出 [cancelScope] 范围、或者离开了元素本身，将执行此回调
  final VoidCallback? onCancel;

  /// 指针移动事件，回调参数是原始指针对象，你可以通过 e.toDetails 转成 [DragUpdateDetails]
  final PointerMoveEventListener? onMove;

  /// 指针结束移动事件
  final PointerMoveEventListener? onMoveEnd;

  /// 指针垂直移动事件，回调参数是原始指针对象，你可以通过 e.toDetails 转成 [DragUpdateDetails]
  final PointerMoveEventListener? onVerticalMove;

  /// 指针结束垂直移动事件
  final PointerMoveEventListener? onVerticalMoveEnd;

  /// 指针水平移动事件，回调参数是原始指针对象，你可以通过 e.toDetails 转成 [DragUpdateDetails]
  final PointerMoveEventListener? onHorizontalMove;

  /// 指针结束水平移动事件
  final PointerMoveEventListener? onHorizontalMoveEnd;
}
