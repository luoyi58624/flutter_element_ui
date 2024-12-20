import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/widgets.dart';

import '../core/model_obs.dart';

ModelObs<T> useModelObs<T extends ElSerializeModel>(
  T initialData, {
  required String cacheKey,
}) {
  return use(_Hook(initialData, cacheKey));
}

class _Hook<T extends ElSerializeModel> extends Hook<ModelObs<T>> {
  const _Hook(
    this.initialData,
    this.cacheKey,
  );

  final T initialData;
  final String cacheKey;

  @override
  _HookState<T> createState() => _HookState();
}

class _HookState<T extends ElSerializeModel>
    extends HookState<ModelObs<T>, _Hook<T>> {
  late final _state = ModelObs<T>(
    hook.initialData,
    cacheKey: hook.cacheKey,
  );

  @override
  void didUpdateHook(_Hook<T> oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.cacheKey != oldHook.cacheKey) {
      _state.cacheKey = hook.cacheKey;
    }
  }

  @override
  ModelObs<T> build(BuildContext context) => _state;

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  String get debugLabel => 'useModelObs<$T>';
}
