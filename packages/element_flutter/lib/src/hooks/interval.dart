import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../common.dart';

/// 定时器钩子，当组件被卸载时会自动取消
Timer useInterval(VoidCallback fun, int wait) {
  return use(_IntervalHook(fun, wait));
}

class _IntervalHook extends Hook<Timer> {
  const _IntervalHook(this.fun, this.wait);

  final VoidCallback fun;
  final int wait;

  @override
  _IntervalHookState createState() => _IntervalHookState();
}

class _IntervalHookState extends HookState<Timer, _IntervalHook> {
  late final _timer = setInterval(hook.fun, hook.wait);

  @override
  Timer build(BuildContext context) => _timer;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
