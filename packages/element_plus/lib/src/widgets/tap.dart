import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:element_dart/element_dart.dart';

extension ElTapExtension on BuildContext {
  /// 通过上下文访问最近的 Tap 点击状态
  bool get isTap => ElTapBuilder.of(this);
}

class ElTapBuilder extends StatefulWidget {
  /// 点击事件构建器
  const ElTapBuilder({
    super.key,
    required this.builder,
    this.delay = 100,
    this.disabled = false,
    this.triggerBuild = true,
    this.hitTestBehavior,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  }) : assert(delay >= 0);

  final WidgetBuilder builder;

  /// 延迟多少毫秒更新点击状态，默认100毫秒，设置一定的延迟时间可以让点击效果更加明显，
  /// 否则，轻点时 tapDown -> tapUp 之间的时间间隔极短，对于依赖 tap 事件而改变状态的元素几乎看不出任何效果
  final int delay;

  /// 是否禁用
  final bool disabled;

  /// 是否触发页面重建，默认true
  final bool triggerBuild;

  final HitTestBehavior? hitTestBehavior;
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) =>
      _TapInheritedWidget.maybeOf(context)?.isTap ?? false;

  @override
  State<ElTapBuilder> createState() => _TapBuilderState();
}

class _TapBuilderState extends State<ElTapBuilder> {
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
                _time = currentMilliseconds;
                if (_timer != null) {
                  _timer!.cancel();
                  _timer = null;
                  update(false);
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
              },
        onTapUp: widget.disabled
            ? null
            : (e) {
                _timer = setTimeout(() {
                  _timer = null;
                  if (mounted) {
                    if (widget.onTapUp != null) widget.onTapUp!(e);
                    update(false);
                  }
                }, max(widget.delay - (currentMilliseconds - _time!), 0));
              },
        onTapCancel: widget.disabled
            ? null
            : () {
                _timer = setTimeout(() {
                  _timer = null;
                  if (mounted) {
                    if (widget.onTapCancel != null) widget.onTapCancel!();
                    update(false);
                  }
                }, widget.delay);
              },
        child: Builder(builder: (context) {
          return widget.builder(context);
        }),
      ),
    );
  }

  void update(bool value) {
    if (widget.triggerBuild && isTap != value) {
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
