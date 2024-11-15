import 'dart:async';
import 'dart:math';

import 'package:element_plus/src/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

part 'state.dart';

part 'prop.dart';

part 'bubble_widget.dart';

part 'extension.dart';

part 'drag.dart';

part 'theme.dart';

part '../../../generates/components/basic/event/index.g.dart';

/// Element UI 交互事件小部件，它包含了悬停、单击、双击、右键、长按、拖拽等功能，几乎所有的组件都基于 [ElEvent] 实现交互。
///
/// 注意：此小部件直接基于 [Listener] 实现，这意味着 [ElEvent] 不参与手势竞技场的竞争，
/// 而 [Listener] 默认自带事件冒泡机制，如果你不做任何处理那么将会触发事件冒泡。
///
/// 因为 [ElEvent] 脱离了 [GestureDetector] 手势竞技场机制，所以解决事件冒泡需要分 3 种情况：
/// 1. [ElEvent] 嵌套 [ElEvent]
/// 2. [ElEvent] 嵌套 [GestureDetector]
/// 3. [GestureDetector] 嵌套 [ElEvent]
///
/// 第一种情况你可以使用以下方案解决事件冒泡：
/// * 在中间插入 [ElStopPropagation] 小部件（最简单）
/// * 在事件中手动执行 context.stopPropagation() 方法
///
/// 对于第二种情况：
/// * [GestureDetector] 底层也是基于 [Listener]，但它注册的事件需要经过一些逻辑计算才会最终响应，
/// 如果你的手指只是轻触，那么 [ElEvent] 的 onTap 事件可能在 [GestureDetector] onTapDown 事件之前触发，
/// 所以你必须使用 [Listener] 包裹子组件，然后在 onPointerDown 事件中执行 context.stopPropagation() 方法。
///
/// 对于第三种情况：
/// * 使用 [ElBubbleBuilder] 包裹外层的小部件，它会捕获内部子组件的停止冒泡信号，
/// builder 回调会传递一个 bool 参数，你需要根据这个 bool 值手动控制函数逻辑的执行。

// 至于为什么不直接基于 GestureDetector 小部件进行封装，为什么要和 Flutter 已有的手势竞技场进行割裂？
// 1. 我可以认真地告诉你，即便我以 GestureDetector 为基础进行封装，它的复杂性也不会变低，对我而言，
// 实现的难度会更大，而你所得到的只是自动帮你处理事件冒泡，这样做也一定会引入其他问题，因为我设计
// 这个小部件的初衷之一就是要手动控制事件冒泡。
// 2. Flutter 的事件系统十分复杂，我对它整个事件体系的理解也仅仅是皮毛，如果 ElEvent 的行为让你很难理解，
// 那么你只需要知道: ElEvent == Listener，所有的一切都是基于 Listener 实现的，仅此而已。
class ElEvent extends StatefulWidget {
  const ElEvent({
    super.key,
    this.child,
    this.builder,
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
  }) : assert(
            (child != null && builder == null) ||
                (child == null && builder != null),
            'ElTap child、builder 参数只能二选一');

  final Widget? child;

  /// 功能和 [child] 一样，只是帮你省略嵌套 [Builder] 小部件，目的是让你正确地通过
  /// context 访问 [isHover]、[isTap] 事件状态
  final WidgetBuilder? builder;

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

  /// 通过上下文获取最近的悬停状态
  static bool isHover(BuildContext context) =>
      _ElEventInheritedWidget.getHoverStatus(context);

  /// 通过上下文获取最近的点击状态
  static bool isTap(BuildContext context) =>
      _ElEventInheritedWidget.getTapStatus(context);

  /// 阻止事件冒泡
  static void stopPropagation(BuildContext context) {
    _ElEventInheritedWidget._stopPropagation(context);
    final result = _ElBubbleInheritedWidget.getWidget(context);
    if (result != null) {
      _ElBubbleInheritedWidget.triggerFlag = true;
      _ElBubbleInheritedWidget._updateBubbleFlag(context, true, result);
    }
  }

  @override
  State<ElEvent> createState() => _ElEventState();
}
