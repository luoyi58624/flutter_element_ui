part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '事件默认配置')
class ElEventThemeData {
  static const theme = ElEventThemeData();
  static const darkTheme = ElEventThemeData();

  const ElEventThemeData({
    this.disabled,
    this.hitTestBehavior,
    this.cursor,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.cancelScope,
    this.onTap,
    this.onContextMenu,
    this.prevent,
    this.onDoubleTap,
    this.doubleTapTimeout,
    this.delayTapForDouble,
    this.onLongPress,
    this.longPressTimeout,
    this.feedback,
  });

  /// 是否禁用，默认 false
  final bool? disabled;

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

  /// 按下事件，回调参数是原始指针对象，你可以通过 e.toDetails 转成 [TapDownDetails]
  final PointerDownEventListener? onTapDown;

  /// 抬起事件，回调参数是原始指针对象，你可以通过 e.toDetails 转成 [TapUpDetails]
  final PointerUpEventListener? onTapUp;

  /// 按下取消事件，当指针按下时，如果指针移动超出 [cancelScope] 范围、或者离开了元素本身，将执行此回调
  final VoidCallback? onTapCancel;

  /// 触发取消事件偏移范围，默认 10 像素
  final int? cancelScope;

  /// 点击事件
  final VoidCallback? onTap;

  /// 右键事件
  final VoidCallback? onContextMenu;

  /// 如果 [onContextMenu] 不为空，是否阻止浏览器右键默认行为，默认 true
  final bool? prevent;

  /// 双击事件
  final VoidCallback? onDoubleTap;

  /// 双击触发时间，默认 300 毫秒
  final int? doubleTapTimeout;

  /// 如果存在双击事件，是否延迟 [onTap] 的执行，若触发了双击事件，那么 [onTap] 将不会触发，
  /// 这是 Flutter 手势竞技场默认行为，但在这里它默认 false，如有需要请手动开启
  final bool? delayTapForDouble;

  /// 长按事件，若激活了长按事件，所有按下事件包括 [onTapCancel] 都不会触发
  final VoidCallback? onLongPress;

  /// 长按触发时间，默认 500 毫秒
  final int? longPressTimeout;

  /// 是否启用长按反馈，在移动端将会触发轻微震动提示，默认 true
  final bool? feedback;
}
