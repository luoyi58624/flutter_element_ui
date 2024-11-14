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

part 'inherited_widget.dart';

part 'extension.dart';

part 'drag.dart';

part 'theme.dart';

part '../../../generates/components/basic/event/index.g.dart';

class ElEvent extends StatefulWidget {
  /// Element UI 事件小部件，它包含了悬停、单击、双击、右键、长按、拖拽等众多功能
  ///
  /// 注意：此小部件直接基于 [Listener] 实现，[Listener] 是 [GestureDetector] 最底层实现，
  /// 这意味着 [ElEvent] 不参与手势竞技场的竞争，如果 [GestureDetector] 嵌套 [ElEvent]，
  /// 那么将会触发事件冒泡，即子组件和父组件都会触发事件。
  ///
  /// 你只能使用 [ElEvent] 去嵌套 [ElEvent]，Element UI 提供了 2 种方式阻止事件冒泡：
  /// * 在事件中执行 context.stopPropagation() 方法
  /// * 添加 [ElStopPropagation] 小部件
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
    this.onMove,
    this.onMoveEnd,
    this.onVerticalMove,
    this.onVerticalMoveEnd,
    this.onHorizontalMove,
    this.onHorizontalMoveEnd,
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

  /// 指针移动事件
  final GestureDragUpdateCallback? onMove;

  /// 指针结束移动事件
  final GestureDragEndCallback? onMoveEnd;

  /// 指针垂直移动事件
  final GestureDragUpdateCallback? onVerticalMove;

  /// 指针结束垂直移动事件
  final GestureDragEndCallback? onVerticalMoveEnd;

  /// 指针水平移动事件
  final GestureDragUpdateCallback? onHorizontalMove;

  /// 指针结束水平移动事件
  final GestureDragEndCallback? onHorizontalMoveEnd;

  /// 指针信号事件，例如：鼠标滚轮滚动
  final PointerSignalEventListener? onPointerSignal;

  /// 通过上下文获取最近的悬停状态
  static bool isHover(BuildContext context) =>
      _ElEventInheritedWidget.getHoverStatus(context);

  /// 通过上下文获取最近的点击状态
  static bool isTap(BuildContext context) =>
      _ElEventInheritedWidget.getTapStatus(context);

  /// 阻止事件冒泡
  static void stopPropagation(BuildContext context) =>
      _ElEventInheritedWidget._stopPropagation(context);

  @override
  State<ElEvent> createState() => _ElEventState();
}