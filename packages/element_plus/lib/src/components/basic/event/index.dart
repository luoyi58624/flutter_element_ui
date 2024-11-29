import 'dart:async';
import 'dart:math';

import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

part 'state.dart';

part 'prop.dart';

part 'widgets/bubble_builder.dart';

part 'extension.dart';

part 'widgets/inherited_widget.dart';

part 'widgets/focus_scope.dart';

part 'widgets/shortcuts.dart';

part 'mixins/bubble.dart';

part 'mixins/common.dart';

part 'mixins/double_tap.dart';

part 'mixins/drag.dart';

part 'mixins/focus.dart';

part 'mixins/hover.dart';

part 'mixins/long_press.dart';

part 'mixins/tap.dart';

part 'theme.dart';

part '../../../generates/components/basic/event/index.g.dart';

/// Element UI 交互事件小部件，它包含了焦点、悬停、单击、双击、右键、长按、拖拽等功能。
///
/// 注意：此小部件直接基于 [Listener] 实现，这意味着 [ElEvent] 不参与手势竞技场的竞争，
/// 嵌套事件小部件会产生事件冒泡。
///
/// 解决事件冒泡需要分 3 种情况：
/// 1. [ElEvent] 嵌套 [ElEvent]
/// 2. [ElEvent] 嵌套 [GestureDetector]
/// 3. [GestureDetector] 嵌套 [ElEvent]
///
/// 第一种情况：
/// * 在中间插入 [ElStopPropagation] 小部件
/// * 在事件中执行 context.stopPropagation() 方法
///
/// 第二种情况：
/// * 你需要插入 [Listener] 小部件，然后在事件中执行 context.stopPropagation() 方法，
/// 这是因为在手指轻触屏幕时，[GestureDetector] onTapDown 事件的触发比 [ElEvent] onTap 还要慢一点。
///
/// 第三种情况：
/// * 你需要使用 [ElBubbleBuilder] 包裹外层的小部件，它会捕获内部子组件的停止事件冒泡信号，
/// builder 回调会传递一个 bool 类型的冒泡标识，你要根据这个标识手动控制逻辑的执行。
class ElEvent extends StatefulWidget {
  const ElEvent({
    super.key,
    this.child,
    this.builder,
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

  /// 功能和 [child] 一样，只是帮你省略嵌套 [Builder] 小部件
  final WidgetBuilder? builder;

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

  /// 指针取消事件，当指针按下时，如果指针移动超出 [cancelScope] 范围、或者离开了元素本身，将执行此回调，
  /// 但是，如果已经触发了长按事件、或者监听了指针移动事件（包括拖拽），那么此回调不会触发。
  final VoidCallback? onCancel;

  /// 通过上下文访问最近的 Hover 悬停状态，如果引用此变量，[ElEvent] 获得悬停事件时将会重建子组件
  static bool hasHover(BuildContext context) =>
      _EventInheritedWidget.getHoverStatus(context);

  /// 通过当前上下文访问最近的 Tap 点击状态，如果引用此变量，[ElEvent] 获得点击事件时将会重建子组件
  static bool hasTap(BuildContext context) =>
      _EventInheritedWidget.getTapStatus(context);

  /// 通过当前上下文访问最近的 Focus 焦点状态，如果引用此变量，[ElEvent] 获得点击事件时将会重建子组件
  static bool hasFocus(BuildContext context) =>
      _EventInheritedWidget.getFocusStatus(context);

  /// 阻止事件冒泡，在大部分情况下你只需嵌套 [ElStopPropagation] 小部件即可，它更简单，
  /// 你无需考虑 context 作用域问题，但如果你想要控制阻止事件冒泡的时机，例如：
  /// 只阻止 onTap 事件但希望父级 onTapDown 能正常触发，那么你可以在 onTap 中执行此函数。
  ///
  /// 它的原理就是运用 [InheritedWidget] 小部件，通过 context 不断向上查找，然后依次更新它们的冒泡标识（bool），
  /// 当上层事件执行时，由于冒泡标识被更改从而阻止逻辑执行，当指针抬起或者指针被取消，再重置冒泡标识。
  ///
  /// 提示：更改冒泡标识不会引起 UI 重建，查找 [InheritedWidget] 小部件的实例很便宜，时间复杂度为 O(1)。
  static void stopPropagation(BuildContext context) {
    _EventInheritedWidget.stopPropagation(context);

    // 查找是否存在 ElBubbleBuilder 小部件，如果有那么需要通知它的回调
    final result = _BubbleInheritedWidget.getWidget(context);
    if (result != null) {
      _BubbleInheritedWidget.triggerFlag = true;
      _BubbleInheritedWidget._updateBubbleFlag(context, true, result);
    }
  }

  /// 重置事件冒泡，如果 [stopPropagation] 是手动触发的（鼠标点击、手指按下），
  /// 那么被阻止的事件在指针抬起时会自动重置冒泡标识，但你若是通过隐式方式调用 [stopPropagation]，
  /// 那么你必须在逻辑处理完后手动重置冒泡标识，否则上层事件将永远无法触发。
  static void resetPropagation(BuildContext context) {
    _EventInheritedWidget.resetPropagation(context);
    final result = _BubbleInheritedWidget.getWidget(context);
    if (result != null) {
      _BubbleInheritedWidget.triggerFlag = false;
      _BubbleInheritedWidget._updateBubbleFlag(context, false, result);
    }
  }

  @override
  State<ElEvent> createState() => _ElEventState();
}
