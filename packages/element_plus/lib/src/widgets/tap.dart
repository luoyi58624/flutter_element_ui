import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../global.dart';

extension ElTapExtension on BuildContext {
  /// 通过当前上下文访问最近的 Tap 点击状态
  bool get isTap => ElTapBuilder.of(this);

  /// 通过当前上下文阻止事件冒泡
  void stopPropagation() => ElTapBuilder.stopPropagation(this);
}

class ElTapBuilder extends StatefulWidget {
  /// 点击事件构建器，主要有两个功能：
  /// * 延迟更新点击状态，让依赖 tap 事件的元素状态更加明显
  /// * 默认允许冒泡，如果点击事件进行嵌套，内部触发的点击事件会一层一层冒泡到外部
  ///
  /// 如果 [ElTapBuilder] 存在嵌套，你有两种方式阻止事件冒泡：
  /// 1. 在事件触发逻辑中调用 [stopPropagation] 方法
  /// 2. 在目标小部件上方添加 [ElStopPropagation] 小部件
  ///
  /// 提示：冒泡行为仅限 [ElTapBuilder] 之间的嵌套，即子级的 [ElTapBuilder]
  /// 冒泡的事件是不会传递到父级的 [GestureDetector] 事件。
  const ElTapBuilder({
    super.key,
    required this.builder,
    this.delay = 100,
    this.disabled = false,
    this.hitTestBehavior,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  }) : assert(delay == 0 || delay >= 50);

  final WidgetBuilder builder;

  /// 延迟多少毫秒更新点击状态，默认100毫秒，设置一定的延迟时间可以让点击效果更加明显，
  /// 它适用于依赖 tap 事件而改变状态的元素，防止轻点时，tapDown -> tapUp 之间极短的时间间隔导致看不出任何效果。
  ///
  /// 注意：这个延迟属性只作用于 onTapUp、onTapCancel 事件，onTap 不受影响。
  final int delay;

  /// 是否禁用
  final bool disabled;

  final HitTestBehavior? hitTestBehavior;
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) =>
      _TapInheritedWidget.maybeOf(context)?.isTap ?? false;

  /// 阻止事件冒泡，执行此函数会从当前持有的 context 开始，阻止上层祖先所有的点击事件（包括 onTapDown），
  /// 然后会在释放时经过极短延迟后自动重置。
  ///
  /// 提示：此函数不会引起 UI 重建，它的原理只是更新 bool 标识，阻止上层点击事件的具体逻辑执行。
  static void stopPropagation(BuildContext context) {
    _TapInheritedWidget._stopPropagation(context);
  }

  @override
  State<ElTapBuilder> createState() => _TapBuilderState();
}

class _TapBuilderState extends State<ElTapBuilder> {
  /// 一个标识，表示是否允许冒泡，若此属性为 false，则阻止当前所有类型的点击事件触发
  bool _bubbleFlag = true;

  /// 是否触发点击
  bool _isTap = false;

  /// 是否存在依赖，如果有那么点击时会自动重建状态
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

  void _onTapDown(TapDownDetails e) {
    _time = currentMilliseconds;
    if (widget.disabled == false && _bubbleFlag) {
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

  void _onTapUp(TapUpDetails e) {
    if (widget.disabled == false && _bubbleFlag) {
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
    if (widget.disabled == false && _bubbleFlag) {
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
      _reset();
      _TapInheritedWidget._stopPropagation(context);
    }
  }

  void _reset() {
    if (!_bubbleFlag) {
      setTimeout(() {
        _bubbleFlag = true;
      }, 1);
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
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{};

    gestures[_ClickGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<_ClickGestureRecognizer>(
      () => _ClickGestureRecognizer(),
      (instance) {
        instance
          ..onTapDown = _onTapDown
          ..onTap = _onTap
          ..onTapUp = _onTapUp
          ..onTapCancel = _onTapCancel;
      },
    );

    return _TapInheritedWidget(
      isTap: _isTap,
      setDependFlag: setDependFlag,
      stopPropagation: _stopPropagation,
      child: RawGestureDetector(
        behavior: widget.hitTestBehavior,
        gestures: gestures,
        child: Builder(builder: (context) {
          return widget.builder(context);
        }),
      ),
    );
  }
}

class _ClickGestureRecognizer extends TapGestureRecognizer {
  /// 重写点击拒绝事件，将拒绝变为允许
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
    super.rejectGesture(pointer);
  }
}

class _TapInheritedWidget extends InheritedWidget {
  const _TapInheritedWidget({
    required super.child,
    required this.isTap,
    required this.setDependFlag,
    required this.stopPropagation,
  });

  final bool isTap;
  final ElBoolVoidCallback setDependFlag;
  final VoidCallback stopPropagation;

  static _TapInheritedWidget? maybeOf(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();
    if (result != null) {
      result.setDependFlag(true);
    }
    return result;
  }

  static void _stopPropagation(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();
    if (result != null) {
      result.stopPropagation();
    }
  }

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) {
    return isTap != oldWidget.isTap;
  }
}
