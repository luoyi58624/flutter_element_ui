import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_element_dart/flutter_element_dart.dart';

import '../common.dart';

class TapBuilder extends StatefulWidget {
  /// 点击事件构建器
  const TapBuilder({
    super.key,
    required this.builder,
    this.hitTestBehavior,
    this.delay = 100,
    this.disabled = false,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  }) : assert(delay >= 0);

  final WidgetBuilder builder;

  /// 命中测试
  final HitTestBehavior? hitTestBehavior;

  /// 延迟多少毫秒更新点击状态，默认100毫秒，设置一定的延迟时间可以让点击效果更加明显
  final int delay;

  /// 是否禁用，默认false
  final bool disabled;

  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) =>
      _TapInheritedWidget.maybeOf(context)?.isTap ?? false;

  @override
  State<TapBuilder> createState() => _TapBuilderState();
}

class _TapBuilderState extends State<TapBuilder> {
  bool isTap = false;
  int? _time;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return _TapInheritedWidget(
      isTap: isTap,
      child: GestureDetector(
        behavior: widget.hitTestBehavior,
        onTap: widget.disabled ? null : widget.onTap,
        onTapDown: widget.disabled
            ? null
            : (e) {
                if (widget.onTapDown != null) widget.onTapDown!(e);
                _time = currentMilliseconds;
                if (_timer != null) {
                  _timer!.cancel();
                  _timer = null;
                  update(false);
                  setTimeout(() => update(true), 16);
                } else {
                  update(true);
                }
              },
        onTapUp: widget.disabled
            ? null
            : (e) {
                if (widget.onTapUp != null) widget.onTapUp!(e);
                _timer = setTimeout(() {
                  update(false);
                  _timer = null;
                }, max(widget.delay - (currentMilliseconds - _time!), 0));
              },
        onTapCancel: widget.disabled
            ? null
            : () {
                if (widget.onTapCancel != null) widget.onTapCancel!();
                _timer = setTimeout(() {
                  update(false);
                  _timer = null;
                }, widget.delay);
              },
        child: Builder(builder: (context) {
          return widget.builder(context);
        }),
      ),
    );
  }

  void update(bool value) {
    if (mounted && isTap != value) {
      setState(() {
        isTap = value;
      });
    }
  }
}

class _TapInheritedWidget extends InheritedWidget {
  const _TapInheritedWidget({
    required super.child,
    required this.isTap,
  });

  final bool isTap;

  static _TapInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) {
    return true;
  }
}
