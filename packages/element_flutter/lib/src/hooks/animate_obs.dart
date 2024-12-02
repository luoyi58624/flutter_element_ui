import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../utils/animate_obs.dart';

AnimateObs<T> useAnimateObs<T>(
  T initialData, {
  Duration duration = const Duration(milliseconds: 250),
  Curve curve = Curves.linear,
  Tween<T>? tween,
}) {
  return use(_ObsHook(initialData, duration, curve, tween));
}

class _ObsHook<T> extends Hook<AnimateObs<T>> {
  const _ObsHook(
    this.initialData,
    this.duration,
    this.curve,
    this.tween,
  );

  final T initialData;
  final Duration duration;
  final Curve curve;
  final Tween<T>? tween;

  @override
  _ObsHookState<T> createState() => _ObsHookState();
}

class _ObsHookState<T> extends HookState<AnimateObs<T>, _ObsHook<T>> {
  late final _state = AnimateObs<T>(
    hook.initialData,
    duration: hook.duration,
    curve: hook.curve,
    tween: hook.tween,
  );

  @override
  void didUpdateHook(_ObsHook<T> oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.duration != oldHook.duration) {
      _state.duration = hook.duration;
    }
    if (hook.curve != oldHook.curve) {
      _state.curve = hook.curve;
    }
    if (hook.tween != oldHook.tween) {
      _state.tween = hook.tween;
    }
  }

  @override
  AnimateObs<T> build(BuildContext context) => _state;

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  String get debugLabel => 'useAnimateObs<$T>';
}
