import 'dart:async';
import 'dart:math';

import 'package:element_plus/src/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

part 'state.dart';

part 'inherited_widget.dart';

part 'extension.dart';

class ElEvent extends StatefulWidget {
  /// Element UI 事件小部件，它整合了悬停、按下、点击、右键、双击、长按、拖拽、焦点、快捷键...
  ///
  /// 注意：此小部件直接基于 [Listener] 实现，所以它不参与手势竞技场的竞争，这意味着它不兼容
  /// [GestureDetector]、[InkWell] 等小部件，你不能同时混用它们，否则会发生事件冒泡。
  ///
  /// 对于嵌套 [ElEvent] 产生的事件冒泡，你有 2 种方式阻止它们：
  /// * 在事件中执行 context.stopPropagation()
  /// * 添加 [ElStopPropagation] 小部件
  const ElEvent({
    super.key,
    required this.child,
    this.disabled = false,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.cursor,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTapDown,
    this.onTapUp,
    this.tapUpDelay = 100,
    this.onTapCancel,
    this.cancelScope = 10,
    this.onTap,
    this.onContextMenu,
    this.prevent = true,
    this.onDoubleTap,
    this.doubleTapTimeout = 300,
    this.delayTapForDouble = false,
    this.onLongPress,
    this.longPressTimeout = 500,
    this.feedback = true,
  }) : assert(tapUpDelay >= 0);

  final Widget child;

  /// 是否禁用，默认 false
  final bool disabled;

  /// 命中测试行为
  final HitTestBehavior hitTestBehavior;

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

  /// [onTapUp] 延迟时间，默认100毫秒，设置一定的延迟时间可以让点击效果更加明显
  final int tapUpDelay;

  /// 按下取消事件，如果指针移动超出一定范围、或者离开了元素本身，将执行此回调
  final VoidCallback? onTapCancel;

  /// 触发取消事件偏移范围，默认 10 像素
  final int cancelScope;

  /// 点击事件
  final VoidCallback? onTap;

  /// 右键事件
  final VoidCallback? onContextMenu;

  /// 如果 [onContextMenu] 不为空，是否阻止浏览器右键默认行为，默认 true
  final bool prevent;

  /// 双击事件
  final VoidCallback? onDoubleTap;

  /// 双击触发时间，默认 300 毫秒
  final int doubleTapTimeout;

  /// 如果存在双击事件，是否延迟 [onTap] 的执行，若触发了双击事件，那么 [onTap] 将不会触发，
  /// 这是 Flutter 手势竞技场默认行为，但在这里它默认 false，如有需要请手动开启
  final bool delayTapForDouble;

  /// 长按事件，若激活了长按事件，所有按下事件包括 [onTapCancel] 都不会触发
  final VoidCallback? onLongPress;

  /// 长按触发时间，默认 500 毫秒
  final int longPressTimeout;

  /// 是否启用长按反馈，在移动端将会触发轻微震动提示，默认 true
  final bool feedback;

  /// 通过上下文获取最近的悬停状态
  static bool isHover(BuildContext context) =>
      _ElEventInheritedWidget.getHoverStatus(context);

  /// 通过上下文获取最近的点击状态
  static bool isTap(BuildContext context) =>
      _ElEventInheritedWidget.getTapStatus(context);

  @override
  State<ElEvent> createState() => _ElEventState();
}
