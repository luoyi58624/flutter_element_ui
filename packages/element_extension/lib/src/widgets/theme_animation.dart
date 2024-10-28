import 'dart:async';
import 'dart:math';

import 'package:element_dart/element_dart.dart';
import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

class ThemeAnimation extends StatefulWidget {
  const ThemeAnimation({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElThemeData data;

  @override
  State<ThemeAnimation> createState() => _ThemeAnimationState();
}

class _ThemeAnimationState extends State<ThemeAnimation> {
  Duration? _themeDuration;
  Curve? _themeCurve;
  Timer? _timer;

  ElConfigThemeData get config => context.elConfig;

  @override
  void didUpdateWidget(covariant ThemeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _changeTheme();
    }
  }

  void _changeTheme() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _themeDuration = config.themeDuration;
    _themeCurve = config.themeCurve;
    _timer = setTimeout(() {
      if (mounted) {
        setState(() {
          _themeDuration = null;
          _themeCurve = null;
          _timer = null;
        });
      }
    }, max(500, config.themeDuration.inMilliseconds));
  }

  @override
  Widget build(BuildContext context) {
    return ThemeAnimationInheritedWidget(
      _themeDuration,
      _themeCurve,
      child: widget.child,
    );
  }
}

class ThemeAnimationInheritedWidget extends InheritedWidget {
  const ThemeAnimationInheritedWidget(
    this.themeDuration,
    this.themeCurve, {
    super.key,
    required super.child,
  });

  final Duration? themeDuration;
  final Curve? themeCurve;

  static ThemeAnimationInheritedWidget of(BuildContext context) {
    final ThemeAnimationInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<ThemeAnimationInheritedWidget>();
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeAnimationInheritedWidget oldWidget) => true;
}
