import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/widgets.dart';

import '../core/local_obs.dart';

LocalObs<T> useLocalObs<T>(
  T initialData, {
  required String cacheKey,
  ElSerialize? serialize,
}) {
  return use(_Hook(initialData, cacheKey, serialize));
}

class _Hook<T> extends Hook<LocalObs<T>> {
  const _Hook(
    this.initialData,
    this.cacheKey,
    this.serialize,
  );

  final T initialData;
  final String cacheKey;
  final ElSerialize? serialize;

  @override
  _HookState<T> createState() => _HookState();
}

class _HookState<T> extends HookState<LocalObs<T>, _Hook<T>> {
  late final _state = LocalObs<T>(
    hook.initialData,
    cacheKey: hook.cacheKey,
    serialize: hook.serialize,
  );

  @override
  void didUpdateHook(_Hook<T> oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.cacheKey != oldHook.cacheKey) {
      _state.cacheKey = hook.cacheKey;
    }
    if (hook.serialize != oldHook.serialize) {
      _state.serialize = hook.serialize;
    }
  }

  @override
  LocalObs<T> build(BuildContext context) => _state;

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  String get debugLabel => 'useLocalObs<$T>';
}
