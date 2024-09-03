import 'dart:async';
import 'dart:math';

import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

class DurationBuilder extends StatefulWidget {
  const DurationBuilder({
    super.key,
    required this.duration,
    required this.builder,
  });

  final Duration duration;
  final WidgetBuilder builder;

  @override
  State<DurationBuilder> createState() => _DurationBuilderState();
}

class _DurationBuilderState extends State<DurationBuilder> {
  Duration? _duration;

  Duration get duration => _duration!;

  set duration(Duration v) {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _duration = v;
  }

  bool flag = true;
  Timer? _timer;

  void updateDuration(int ms) {
    _timer = () {
      _timer = null;
      setState(() {
        flag = false;
        duration = GlobalConfig.themeDuration;
      });
    }.delay(ms);
  }

  @override
  Widget build(BuildContext context) {
    if (flag) {
      final $1 = widget.duration.inMilliseconds;
      final $2 = GlobalConfig.themeDuration.inMilliseconds;
      if ($1 == $2) {
        duration = widget.duration;
      } else {
        if (context.isHover || context.isTap) {
          duration = widget.duration;
        } else {
          duration = widget.duration;
          updateDuration(max($1, $2));
        }
      }
    } else {
      flag = true;
    }

    return _DurationBuilderInheritedWidget(
      duration,
      child: Builder(builder: (context) {
        return widget.builder(context);
      }),
    );
  }
}

class _DurationBuilderInheritedWidget extends InheritedWidget {
  const _DurationBuilderInheritedWidget(
    this.duration, {
    required super.child,
  });

  final Duration duration;

  static _DurationBuilderInheritedWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_DurationBuilderInheritedWidget>();
  }

  @override
  bool updateShouldNotify(_DurationBuilderInheritedWidget oldWidget) => true;
}
