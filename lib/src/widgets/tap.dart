import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

class TapBuilder extends StatefulWidget {
  /// 点击事件构建器
  const TapBuilder({
    super.key,
    required this.builder,
    this.onTap,
    this.delay = 100,
    this.disabled = false,
  }) : assert(delay >= 0);

  final WidgetBuilder builder;

  final GestureTapCallback? onTap;

  /// 延迟多少毫秒更新点击状态，默认100毫秒，设置一定的延迟时间可以让点击效果更加明显，
  /// 否则你应当直接使用[GestureDetector]，同时，如果你需要根据状态变更应用过渡动画，
  /// 那么你应当设置与过渡动画同等的延迟时间，否则过渡动画还未加载完就将被迫重置状态
  final int delay;

  /// 是否禁用，默认false
  final bool disabled;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) =>
      _TapInheritedWidget.of(context)?.isTap ?? false;

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
        onTap: widget.disabled ? null : widget.onTap,
        onTapDown: widget.disabled
            ? null
            : (e) {
                _time = currentMilliseconds;
                if (_timer != null) {
                  _timer!.cancel();
                  _timer = null;
                  update(false);
                  (() => update(true)).delay(16);
                } else {
                  update(true);
                }
              },
        onTapUp: widget.disabled
            ? null
            : (e) {
                _timer = () {
                  update(false);
                  _timer = null;
                }.delay(max(widget.delay - (currentMilliseconds - _time!), 0));
              },
        onTapCancel: widget.disabled
            ? null
            : () {
                _timer = () {
                  update(false);
                  _timer = null;
                }.delay(widget.delay);
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

  static _TapInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) {
    return true;
  }
}
