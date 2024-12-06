import 'package:element_annotation/element_annotation.dart';
import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/widgets.dart';

ModelObs<T> useModelObs<T extends SerializeModel>(
  T initialData, {
  required String cacheKey,
}) {
  return use(_Hook(initialData, cacheKey));
}

class _Hook<T extends SerializeModel> extends Hook<ModelObs<T>> {
  const _Hook(
    this.initialData,
    this.cacheKey,
  );

  final T initialData;
  final String cacheKey;

  @override
  _HookState<T> createState() => _HookState();
}

class _HookState<T extends SerializeModel>
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
