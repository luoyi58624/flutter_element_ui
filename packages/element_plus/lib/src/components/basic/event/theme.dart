part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '事件默认配置')
class ElEventThemeData {
  static const _default = ElEventThemeData(
    tapUpDelay: 100,
  );
  static const theme = _default;
  static const darkTheme = _default;

  /// 在 Element UI 中，事件也拥有主题数据，你不仅可以配置事件的全局属性（取消偏移范围、开启长按反馈、拖拽偏移幅度...），
  /// 还可以为任意一个组件注入所有事件（悬停、双击、长按、右键、拖拽...），这样的机制大大简化了每个组件的 prop 参数，
  /// 例如 [ElButton] 只需提供 onPressed 参数即可，更多事件你可以通过 [ElEventTheme] 注入。
  ///
  /// 当然，事件主题数据也同样遵循 Component -> LocalTheme -> GlobalTheme 这样主题合并机制，
  /// 对于组件开发者来说，如果你实现的组件占用了某些事件，若你希望用户可以通过 [ElEventTheme] 注入默认事件，
  /// 只需在组件事件中调用默认事件即可。
  ///
  /// 例如 [ElButton] 占用了 onTapDown、onTapUp 等事件，只需在事件逻辑中编写以下代码：
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
    this.triggerDragScope,
    this.minVelocity,
    this.maxVelocity,
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
    this.onTertiaryTap,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTapOutside,
    this.onDoubleTap,
    this.onLongPress,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
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
  ///
  /// 在 Flutter 中，要正确理解 focus 焦点系统可不是一件容易的事，而 [ElEvent] 作为基础小部件，
  /// 并不是所有的节点都需要支持焦点，所以在默认情况下，是不允许请求焦点。
  final bool? canRequestFocus;

  /// 触发取消事件偏移范围，默认 20 像素
  final int? cancelScope;

  /// 当注册了 [onSecondaryTap] 时，是否阻止浏览器右键默认行为，默认 true
  final bool? prevent;

  /// 指针抬起延迟时间，作用是让 [isTap] 状态效果更好，默认 100 毫秒
  final int? tapUpDelay;

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

  /// 拖拽结束时触发惯性速度的最小力度，当滑动力度小于该值，其返回的速度将为 0，默认 [kMinFlingVelocity]
  final double? minVelocity;

  /// 拖拽结束时触发惯性速度的最大值，默认 [kMaxFlingVelocity]
  final double? maxVelocity;

  /// 命中测试行为，默认：[HitTestBehavior.deferToChild]，这也是 [Listener] 的默认值，
  /// 关于 [HitTestBehavior] 的三个行为，这里简单列举一下：
  /// * [HitTestBehavior.deferToChild] - 命中透明部分事件会被忽略
  /// * [HitTestBehavior.opaque] - 命中透明部分事件也能触发
  /// * [HitTestBehavior.translucent] - 命中透明部分事件也能触发，同时位于元素下面的目标也能接收事件
  ///
  /// 以 Stack 为例，堆叠了两个小部件，下方小部件颜色随机，上方小部件颜色透明，点击重叠区域的行为如下：
  /// * [HitTestBehavior.deferToChild] - 下方小部件触发事件
  /// * [HitTestBehavior.opaque] - 上方小部件触发事件
  /// * [HitTestBehavior.translucent] - 上方、下方小部件同时触发事件，但 [GestureDetector] 由于存在手势竞技场机制，所以它依然只有上方小部件触发事件
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

  /// 第三级按钮的指针回调，例如：鼠标中键
  final GestureTapCallback? onTertiaryTap;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;

  /// 在元素外进行了点击，如果你监听了 Outside 系列事件，那么 Widget 将会包裹 [TapRegion] 小部件，
  /// 这个小部件会定义一个区域，该区域会检查内部、外部的点击，而且它不参与手势消歧系统，
  final TapRegionCallback? onTapOutside;

  /// 双击事件
  final VoidCallback? onDoubleTap;

  /// 长按事件
  final VoidCallback? onLongPress;

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
}
