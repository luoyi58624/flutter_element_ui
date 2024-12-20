import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_obs/flutter_obs.dart';

/// 适配[flutter_hooks]库，相对于在[StatelessWidget]中直接使用[Obs]，它可以在小部件重建时保存当前状态
Obs<T> useObs<T>(T initialData) {
  return use(_Hook(initialData));
}

class _Hook<T> extends Hook<Obs<T>> {
  const _Hook(this.initialData);

  final T initialData;

  @override
  _HookState<T> createState() => _HookState();
}

class _HookState<T> extends HookState<Obs<T>, _Hook<T>> {
  late final _state = Obs<T>(hook.initialData);

  @override
  Obs<T> build(BuildContext context) => _state;

  @override
  void dispose() {
    super.dispose();
    _state.dispose();
  }

  @override
  String get debugLabel => 'useObs<$T>';
}
