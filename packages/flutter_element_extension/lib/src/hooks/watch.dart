import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_obs/flutter_obs.dart';

/// 监听响应式变量钩子：
/// ```dart
/// useWatch(modelValue, (newValue, oldValue) {});
/// ```
void useWatch<T>(
  ValueNotifier<T> modelValue,
  WatchCallback<T> watchFun,
) {
  use(_WatchHook(modelValue, watchFun));
}

class _WatchHook<T> extends Hook {
  const _WatchHook(this.modelValue, this.watchFun);

  final ValueNotifier<T> modelValue;
  final WatchCallback<T> watchFun;

  @override
  _WatchHookState<T> createState() => _WatchHookState();
}

class _WatchHookState<T> extends HookState<void, _WatchHook<T>> {
  late T newValue;
  late T oldValue;

  void _listenFun() {
    if (newValue != hook.modelValue.value) {
      oldValue = newValue;
      newValue = hook.modelValue.value;
      hook.watchFun(newValue, oldValue);
    }
  }

  @override
  void initHook() {
    super.initHook();
    newValue = hook.modelValue.value;
    oldValue = hook.modelValue.value;
    hook.modelValue.addListener(_listenFun);
  }

  @override
  void didUpdateHook(_WatchHook<T> oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.modelValue != oldHook.modelValue) {
      oldHook.modelValue.removeListener(_listenFun);
      hook.modelValue.addListener(_listenFun);
    }
  }

  @override
  void dispose() {
    super.dispose();
    hook.modelValue.removeListener(_listenFun);
  }

  @override
  void build(BuildContext context) {}
}
