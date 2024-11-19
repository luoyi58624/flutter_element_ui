import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/components/basic/event/prop.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'inherited_widget.dart';
import 'mixins/common.dart';
import 'mixins/double_tap.dart';
import 'mixins/drag.dart';
import 'mixins/hover.dart';
import 'mixins/long_press.dart';
import 'mixins/tap.dart';

part 'state.dart';

part 'bubble_widget.dart';

part 'extension.dart';

part 'theme.dart';

part '../../../generates/components/basic/event/index.g.dart';

/// Element UI 交互事件小部件，它包含了悬停、单击、双击、右键、长按、拖拽等功能。
///
/// 注意：此小部件直接基于 [Listener] 实现，这意味着 [ElEvent] 不参与手势竞技场的竞争，
/// 如果你不做任何处理那么将会触发事件冒泡。
///
/// 解决事件冒泡需要分 3 种情况：
/// 1. [ElEvent] 嵌套 [ElEvent]
/// 2. [ElEvent] 嵌套 [GestureDetector]
/// 3. [GestureDetector] 嵌套 [ElEvent]
///
/// 第一种情况你可以使用以下方案解决事件冒泡：
/// * 在中间插入 [ElStopPropagation] 小部件
/// * 在事件中手动执行 context.stopPropagation() 方法
///
/// 对于第二种情况：
/// * 你必须在 [GestureDetector] 上方插入 [Listener] 小部件，然后在 [Listener] 小部件的事件中执行 context.stopPropagation() 方法，
/// 这是因为当手指轻触屏幕时，onTapDown 的触发时机可能比 [ElEvent] 的 [onTap] 还要慢。
///
/// 对于第三种情况：
/// * 你需要使用 [ElBubbleBuilder] 包裹外层的小部件，它会捕获内部子组件的停止事件冒泡信号，
/// builder 回调会传递一个 bool 参数，你要根据这个 bool 值手动控制函数逻辑的执行，
/// 注意这个方案会引发 UI 重建。
///
///
/// 为什么不直接基于 [GestureDetector] 小部件，而要重新实现已有轮子？
///
/// 因为必须要实现手动控制事件冒泡机制，否则无法处理 [Listener] 嵌套 [GestureDetector]，
/// 若基于 [GestureDetector] 进行封装，你就需要和手势竞技场做斗争，这样做会令代码变得更加复杂。
class ElEvent extends StatefulWidget {
  /// Element UI 事件交互构造器
  const ElEvent({
    super.key,
    this.child,
    this.builder,
    this.disabled,
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
    this.hitTestBehavior,
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
    this.onTapOutside,
    this.onCancel,
  }) : assert(
            (child != null && builder == null) ||
                (child == null && builder != null),
            'ElTap child、builder 参数只能二选一');

  final Widget? child;

  /// 功能和 [child] 一样，只是帮你省略嵌套 [Builder] 小部件，添加这个属性主要是为了兼容以前 ElTap、ElHover 的旧写法（现在这两个小部件合并为 ElEvent）
  final WidgetBuilder? builder;

  /// 是否禁用，默认 false
  final bool? disabled;

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

  /// 指针取消事件，当指针按下时，如果指针移动超出 [cancelScope] 范围、或者离开了元素本身，将执行此回调，
  /// 但是，如果已经触发了长按事件、或者监听了指针移动事件（包括拖拽），那么此回调不会触发。
  final VoidCallback? onCancel;

  /// 通过上下文获取最近的悬停状态
  static bool isHover(BuildContext context) =>
      EventInheritedWidget.getHoverStatus(context);

  /// 通过上下文获取最近的点击状态
  static bool isTap(BuildContext context) =>
      EventInheritedWidget.getTapStatus(context);

  /// 阻止事件冒泡
  static void stopPropagation(BuildContext context) {
    EventInheritedWidget.stopPropagation(context);

    // 查找是否存在 ElBubbleBuilder 小部件，如果有那么需要通知它的回调
    final result = _ElBubbleInheritedWidget.getWidget(context);
    if (result != null) {
      _ElBubbleInheritedWidget.triggerFlag = true;
      _ElBubbleInheritedWidget._updateBubbleFlag(context, true, result);
    }
  }

  /// 重置事件冒泡
  static void resetPropagation(BuildContext context) {
    EventInheritedWidget.resetPropagation(context);
    final result = _ElBubbleInheritedWidget.getWidget(context);
    if (result != null) {
      _ElBubbleInheritedWidget.triggerFlag = false;
      _ElBubbleInheritedWidget._updateBubbleFlag(context, false, result);
    }
  }

  @override
  State<ElEvent> createState() => _ElEventState();
}
