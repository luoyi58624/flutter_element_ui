import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_obs/flutter_obs.dart';

/// 适配[flutter_hooks]库，相对于在[StatelessWidget]中直接使用[Obs]，它可以在小部件重建时保存当前状态
Obs<T> useObs<T>(
  T initialData, {
  bool auto = true,
  ObsWatchCallback<T>? watch,
  bool immediate = false,
}) {
  return use(_ObsHook(
    initialData: initialData,
    auto: auto,
    watch: watch,
    immediate: immediate,
  ));
}

/// 在开发模式下禁用hook
Obs<T> useDebugObs<T>(
  T initialData, {
  bool auto = true,
  ObsWatchCallback<T>? watch,
  bool immediate = false,
}) {
  return kDebugMode
      ? Obs(initialData, auto: auto, watch: watch, immediate: immediate)
      : useObs(initialData, auto: auto, watch: watch, immediate: immediate);
}

class _ObsHook<T> extends Hook<Obs<T>> {
  const _ObsHook({
    required this.initialData,
    required this.auto,
    this.watch,
    required this.immediate,
  });

  final T initialData;
  final bool auto;
  final ObsWatchCallback<T>? watch;
  final bool immediate;

  @override
  _ObsHookState<T> createState() => _ObsHookState();
}

class _ObsHookState<T> extends HookState<Obs<T>, _ObsHook<T>> {
  late final _state = Obs<T>(hook.initialData, watch: hook.watch);

  @override
  Obs<T> build(BuildContext context) => _state;

  @override
  Object? get debugValue => _state.value;

  @override
  String get debugLabel => 'useObs<$T>';
}
