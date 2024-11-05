import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';

import '../global.dart';

extension ElTapExtension on BuildContext {
  /// 通过当前上下文访问最近的 Tap 点击状态
  bool get isTap => ElTapBuilder.of(this);

  /// 通过当前上下文阻止事件冒泡
  void stopPropagation() => ElTapBuilder.stopPropagation(this);
}

extension ElPointerDownEventExtension on PointerDownEvent {
  /// 将 tapDown 原始指针事件转成 [TapDownDetails]
  TapDownDetails get toDetails => TapDownDetails(
        globalPosition: position,
        localPosition: localPosition,
        kind: kind,
      );
}

extension ElPointerUpEventExtension on PointerUpEvent {
  /// 将 tapUp 原始指针事件转成 [TapUpDetails]
  TapUpDetails get toDetails => TapUpDetails(
        globalPosition: position,
        localPosition: localPosition,
        kind: kind,
      );
}

class ElTapBuilder extends StatefulWidget {
  /// 点击事件构建器，它基于最原始的小部件 [Listener] 进行封装，主要有两个功能：
  /// * 延迟更新点击状态，让依赖 tap 事件的元素状态更加明显
  /// * 默认允许冒泡，如果 [ElTapBuilder] 存在嵌套，内部触发的事件会存在冒泡行为
  ///
  /// 你有两种方式阻止事件冒泡：
  /// 1. 在事件触发逻辑中调用 [stopPropagation] 方法
  /// 2. 在目标小部件上方添加 [ElStopPropagation] 小部件
  ///
  /// 提示：事件冒泡是 [Listener] 小部件默认行为，它没有手势竞技场的概念，常用的
  /// [GestureDetector] 小部件内部也是对 [Listener] 进行的封装。
  const ElTapBuilder({
    super.key,
    required this.builder,
    this.delay = 100,
    this.disabled = false,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  }) : assert(delay == 0 || delay >= 50);

  final WidgetBuilder builder;

  /// 延迟多少毫秒更新点击状态，默认100毫秒，设置一定的延迟时间可以让点击效果更加明显，
  /// 它适用于依赖 tap 事件而改变状态的元素，防止轻点时 tapDown -> tapUp 之间极短的时间间隔导致看不出任何效果。
  ///
  /// 提示：这个延迟属性只作用于 [onTapUp] 事件，[onTap] 事件逻辑不受影响，通常情况下保持默认值即可。
  final int delay;

  /// 是否禁用
  final bool disabled;

  final HitTestBehavior hitTestBehavior;
  final VoidCallback? onTap;
  final PointerDownEventListener? onTapDown;
  final PointerUpEventListener? onTapUp;
  final VoidCallback? onTapCancel;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) =>
      _TapInheritedWidget.maybeOf(context)?.isTap ?? false;

  /// 阻止事件冒泡，执行此函数会从当前持有的 context 开始，阻止上层祖先所有的点击事件（包括 onTapDown），
  /// 然后会在释放时自动重置。
  ///
  /// 提示：此函数不会引起 UI 重建，它只是更新一个 bool 标识，阻止上层点击事件的具体逻辑执行，
  /// 而通过 context 一层一层查找 [InheritedWidget] 时间复杂度为 O(1)。
  static void stopPropagation(BuildContext context) {
    _TapInheritedWidget._stopPropagation(context);
  }

  @override
  State<ElTapBuilder> createState() => _TapBuilderState();
}

class _TapBuilderState extends State<ElTapBuilder> {
  GlobalKey childKey = GlobalKey();

  Size childSize = Size.zero;

  /// 一个标识，表示是否允许冒泡，若此属性为 false，则阻止当前所有类型的点击事件触发
  bool _bubbleFlag = true;

  /// 是否触发点击
  bool _isTap = false;

  /// 当指针在当前小部件按下时，如果指针移动超出小部件的范围，则触发取消事件
  bool _isCancel = false;

  /// 是否存在依赖，如果有那么会自动触发 setState
  bool hasDepend = false;

  /// 每次按下都会记录当前的按下时间
  int? _time;

  /// 延迟释放计时器
  Timer? _timer;

  void setDependFlag(bool value) {
    hasDepend = value;
  }

  void _onTap() {
    if (widget.disabled == false && _bubbleFlag) {
      if (widget.onTap != null) widget.onTap!();
    }
  }

  void _onTapDown(PointerDownEvent e) {
    if (!widget.disabled && _bubbleFlag) {
      _time = currentMilliseconds;
      _isCancel = false;
      ElStopPropagation.of(context, ElTapBuilder.stopPropagation);
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
        setTimeout(() {
          if (mounted) {
            if (widget.onTapDown != null) widget.onTapDown!(e);
            update(true);
          }
        }, 16);
      } else {
        if (widget.onTapDown != null) widget.onTapDown!(e);
        update(true);
      }
    }
  }

  void _onTapUp(PointerUpEvent e) {
    if (!widget.disabled && _bubbleFlag) {
      if (!_isCancel) _onTap();
      _reset();
      _timer = setTimeout(() {
        _timer = null;
        if (mounted) {
          if (widget.onTapUp != null) widget.onTapUp!(e);
          update(false);
        }
      }, max(widget.delay - (currentMilliseconds - _time!), 0));
    }
  }

  void _onTapCancel() {
    if (_isCancel) return;
    _reset();
    _isCancel = true;
    if (!widget.disabled && _bubbleFlag) {
      _timer = setTimeout(() {
        _timer = null;
        if (mounted) {
          if (widget.onTapCancel != null) widget.onTapCancel!();
          update(false);
        }
      }, widget.delay);
    }
  }

  void _stopPropagation() {
    if (_bubbleFlag) {
      _bubbleFlag = false;
      _TapInheritedWidget._stopPropagation(context);
    }
  }

  void _resetPropagation() {
    if (!_bubbleFlag) {
      _bubbleFlag = true;
      _TapInheritedWidget._resetPropagation(context);
    }
  }

  void _reset() {
    if (mounted) {
      final result =
          context.getInheritedWidgetOfExactType<_TapInheritedWidget>();
      if (result != null) {
        setTimeout(() {
          result.resetPropagation();
        }, 1);
      }
    }
  }

  void update(bool value) {
    if (hasDepend && _isTap != value) {
      setState(() {
        _isTap = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    nextTick(() {
      childSize = childKey.currentContext?.size ?? Size.zero;
    });
    return _TapInheritedWidget(
      isTap: _isTap,
      setDependFlag: setDependFlag,
      stopPropagation: _stopPropagation,
      resetPropagation: _resetPropagation,
      child: Listener(
        behavior: widget.hitTestBehavior,
        onPointerDown: _onTapDown,
        onPointerUp: _onTapUp,
        onPointerCancel: (e) => _onTapCancel(),
        onPointerMove: (e) {
          if (!childSize.contains(e.localPosition)) _onTapCancel();
        },
        child: Builder(
          key: childKey,
          builder: (context) {
            return widget.builder(context);
          },
        ),
      ),
    );
  }
}

class _TapInheritedWidget extends InheritedWidget {
  const _TapInheritedWidget({
    required super.child,
    required this.isTap,
    required this.setDependFlag,
    required this.stopPropagation,
    required this.resetPropagation,
  });

  final bool isTap;
  final ElBoolVoidCallback setDependFlag;
  final VoidCallback stopPropagation;
  final VoidCallback resetPropagation;

  static _TapInheritedWidget? maybeOf(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();
    if (result != null) {
      result.setDependFlag(true);
    }
    return result;
  }

  static void _stopPropagation(BuildContext context) {
    final result = context.getInheritedWidgetOfExactType<_TapInheritedWidget>();
    if (result != null) {
      result.stopPropagation();
    }
  }

  static void _resetPropagation(BuildContext context) {
    final result = context.getInheritedWidgetOfExactType<_TapInheritedWidget>();
    if (result != null) {
      result.resetPropagation();
    }
  }

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) {
    return isTap != oldWidget.isTap;
  }
}
