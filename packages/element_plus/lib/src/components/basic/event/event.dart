import 'dart:async';
import 'dart:math';

import 'package:element_plus/src/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

part 'prop.dart';

part 'widgets/bubble_builder.dart';

part 'extension.dart';

part 'widgets/inherited_widget.dart';

part 'widgets/focus_scope.dart';

part 'widgets/shortcuts.dart';

part 'stop_propagation.dart';

part 'mixins/bubble.dart';

part 'mixins/common.dart';

part 'mixins/double_tap.dart';

part 'mixins/focus.dart';

part 'mixins/hover.dart';

part 'mixins/long_press.dart';

part 'mixins/tap.dart';

part 'theme.dart';

part '../../../generates/components/basic/event/event.g.dart';

/// Element UI 交互事件小部件，它包含了焦点、悬停、单击、双击、右键、长按等功能，此小部件直接基于 [Listener] 实现，
/// 这意味着 [ElEvent] 不参与手势竞技场的竞争，默认情况下嵌套事件会产生事件冒泡：
/// 1. 如果是 [ElEvent] 嵌套其他小部件，那么只需要插入 [ElStopPropagation] 即可；
/// 2. 如果是其他小部件嵌套 [ElEvent]，那么你需要使用 [ElBubbleBuilder] 包裹外层的小部件，
/// 然后通过 [ElBubbleBuilder.of] 获取冒泡标识手动阻止逻辑的执行；
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

  /// 在 web 平台上，是否阻止浏览器右键默认行为，默认 true
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

  /// 主指针按下事件，与 [onPointerDown] 原生指针按下事件主要区别在于，它多了 1 毫秒的延迟
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

  /// 指针取消事件，当指针按下时，如果指针移动超出 [cancelScope] 范围、或者离开了元素本身，将执行此回调，
  /// 但是，如果已经触发了长按事件、或者监听了指针移动事件，那么此回调永远不会触发。
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

  @override
  State<ElEvent> createState() => _ElEventState();
}

class _ElEventState extends State<ElEvent>
    with
        _CommonMixin,
        _FocusMixin,
        _LongPressMixin,
        _HoverMixin,
        _TapMixin,
        _DoubleTapMixin,
        _BubbleMixin {
  /// 指针按下事件
  void onPointerDown(PointerDownEvent e) async {
    if (!bubbleFlag) return;
    setPointerDownDetails(e);
    // 指针按下时立即设置选中的焦点，这里只做预选中，当触发点击事件时将请求焦点
    if (_focusScopeWidget != null) {
      _focusScopeWidget!.setPointerDownFocusNode(focusNode);
      if (focusScopeNode!.hasFocus) {
        focusNode!.requestFocus();
      }
    }

    prop.onPointerDown?.call(e);

    if (pointType == kPrimaryButton) {
      await tapDownDelay.delay();
      tapDownHandler(e);
      longPressStartHandler(e);
    } else if (pointType == kSecondaryButton) {
      if (kIsWeb) {
        if (prop.onSecondaryTapDown != null ||
            prop.onSecondaryTap != null ||
            prop.onSecondaryTapUp != null) {
          if (prop.prevent) {
            if (preventContextMenuTimer != null) {
              preventContextMenuTimer!.cancel();
              preventContextMenuTimer = null;
            } else {
              await BrowserContextMenu.disableContextMenu();
            }
          }
        }
      }

      await tapDownDelay.delay();
      prop.onSecondaryTapDown?.call(e.toDetails);
    }
  }

  /// 指针抬起事件
  void onPointerUp(PointerUpEvent e) async {
    resetBubbleBuilderWidget();
    if (!bubbleFlag) {
      bubbleFlag = true;
      return;
    }

    prop.onPointerUp?.call(e);
    if (pointType == kPrimaryButton) {
      doubleTapHandler(e); // doubleTap 要放 tap 前面，因为需要注册计时器
      tapUpHandler(e);
    } else if (pointType == kSecondaryButton) {
      prop.onSecondaryTapUp?.call(e.toDetails);
      if (isCancel == false) prop.onSecondaryTap?.call();
      if (kIsWeb) {
        if (prop.onSecondaryTapDown != null ||
            prop.onSecondaryTap != null ||
            prop.onSecondaryTapUp != null) {
          if (prop.prevent) {
            preventContextMenuTimer ??= setTimeout(() {
              BrowserContextMenu.enableContextMenu();
              preventContextMenuTimer = null;
            }, 100);
          }
        }
      }
    }

    if (isCancel == false) {
      isActiveDoubleTap = false;
      isActiveLongPress = false;
    }
  }

  /// 指针取消事件，有三个触发点：
  /// 1. 当 [Listener] 的 onPointerCancel 触发
  /// 2. 指针移动到元素外部
  /// 3. 指针在元素内部移动偏移幅度太大
  void onPointerCancel() {
    resetBubbleBuilderWidget();
    if (!bubbleFlag) {
      bubbleFlag = true;
      return;
    }
    if (isCancel) return;
    isCancel = true;

    hasTap = false;
    e('取消了', hasTap);
    isActiveDoubleTap = false;
    isActiveLongPress = false;
    cancelLongPressTimer();
    prop.onCancel?.call();
  }

  /// 指针移动事件
  void onPointerMove(PointerMoveEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerMove?.call(e);
    if (isCancel == false && isActiveLongPress == false) {
      // 如果指针离开元素，则立即取消
      if (!childSize.contains(e.localPosition)) {
        onPointerCancel();
      }
      // 如果指针移动偏移大于预定值，则取消
      else if ((e.position - tapDownOffset).distance > prop.cancelScope) {
        onPointerCancel();
      }
    }
  }

  /// 指针平移缩放开始事件
  void onPointerPanZoomStart(PointerPanZoomStartEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerPanZoomStart?.call(e);
  }

  /// 指针平移缩放更新事件
  void onPointerPanZoomUpdate(PointerPanZoomUpdateEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerPanZoomUpdate?.call(e);
  }

  /// 指针平移缩放结束事件
  void onPointerPanZoomEnd(PointerPanZoomEndEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerPanZoomEnd?.call(e);
  }

  /// 指针信号事件，例如：鼠标滚动滚动
  void onPointerSignal(PointerSignalEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerSignal?.call(e);
  }

  @override
  Widget build(BuildContext context) {
    prop = _Prop.create(context, widget);

    Widget result = ObsBuilder(
      builder: (context) {
        return _EventInheritedWidget(
          hasHover,
          setHoverDepend,
          hasTap,
          setTapDepend,
          hasFocus,
          setFocusDepend,
          stopPropagation,
          child: Builder(
            key: childKey,
            builder: (context) => widget.child ?? widget.builder!(context),
          ),
        );
      },
    );

    // 只有在桌面端才渲染鼠标悬停小部件，移动端不存在悬停事件
    if (PlatformUtil.isDesktop) {
      if (prop.disabled) hasHover = false;
      result = MouseRegion(
        cursor: prop.cursor,
        hitTestBehavior: prop.behavior,
        onHover: prop.disabled ? null : prop.onHover,
        onEnter: prop.disabled ? null : onEnter,
        onExit: prop.disabled ? null : onExit,
        child: result,
      );
    }

    if (prop.disabled == false) {
      result = Listener(
        behavior: prop.behavior,
        onPointerDown: onPointerDown,
        onPointerUp: onPointerUp,
        onPointerCancel: (e) => onPointerCancel(),
        onPointerMove: onPointerMove,
        onPointerPanZoomStart: onPointerPanZoomStart,
        onPointerPanZoomUpdate: onPointerPanZoomUpdate,
        onPointerPanZoomEnd: onPointerPanZoomEnd,
        onPointerSignal: onPointerSignal,
        child: result,
      );
    }

    focusScopeWidget = _FocusScopeLookupBoundary.getWidget(context);
    if (focusScopeWidget != null) {
      if (focusNode == null) {
        focusNode = FocusNode();
        focusNode!.addListener(listenerFocus);
      }

      // 创建 ElFocusScope 隔离边界，防止嵌套 ElEvent 小部件重复创建 Focus 焦点，
      // 这么做的目的是：只有当用户使用了 ElFocusScope 小部件，下面 ElEvent 才会创建焦点，
      // 同时，如果 ElEvent 嵌套 ElEvent，内部 ElEvent 要想获得焦点就必须再次插入 ElFocusScope。
      result = _FocusScopeLookupBoundary(
        child: Focus(
          focusNode: focusNode,
          autofocus: prop.autofocus,
          canRequestFocus: prop.canRequestFocus,
          child: result,
        ),
      );
    }

    return result;
  }
}
