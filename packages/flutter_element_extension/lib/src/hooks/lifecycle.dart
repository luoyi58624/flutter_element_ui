import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../global.dart';

/// initState 之前执行
void useBeforeInit(VoidCallback fun) {
  use(_LifecycleHook(_Lifecycle.beforeInit, fun));
}

/// initState 之后执行
void useInit(VoidCallback fun) {
  use(_LifecycleHook(_Lifecycle.init, fun));
}

/// 组件 build 挂载完成后执行，它只会触发一次
void useMounted(VoidCallback fun) {
  use(_LifecycleHook(_Lifecycle.mounted, fun));
}

/// deactivate 之前执行
void useBeforeDeactivate(VoidCallback fun) {
  use(_LifecycleHook(_Lifecycle.beforeDeactivate, fun));
}

/// deactivate 之后执行
void useDeactivate(VoidCallback fun) {
  use(_LifecycleHook(_Lifecycle.deactivate, fun));
}

/// dispose 之前执行
void useBeforeDispose(VoidCallback fun) {
  use(_LifecycleHook(_Lifecycle.beforeDispose, fun));
}

/// dispose 之后执行
void useDispose(VoidCallback fun) {
  use(_LifecycleHook(_Lifecycle.dispose, fun));
}

enum _Lifecycle {
  beforeInit,
  init,
  mounted,
  beforeDeactivate,
  deactivate,
  beforeDispose,
  dispose,
}

class _LifecycleHook extends Hook {
  const _LifecycleHook(this.lifecycle, this.fun);

  final _Lifecycle lifecycle;
  final VoidCallback fun;

  @override
  _LifecycleHookState createState() => _LifecycleHookState();
}

class _LifecycleHookState extends HookState<void, _LifecycleHook> {
  @override
  void initHook() {
    if (hook.lifecycle == _Lifecycle.beforeInit) hook.fun();
    super.initHook();
    if (hook.lifecycle == _Lifecycle.init) {
      hook.fun();
    } else if (hook.lifecycle == _Lifecycle.mounted) {
      nextTick(hook.fun);
    }
  }

  @override
  void deactivate() {
    if (hook.lifecycle == _Lifecycle.beforeDeactivate) hook.fun();
    super.deactivate();
    if (hook.lifecycle == _Lifecycle.deactivate) hook.fun();
  }

  @override
  void dispose() {
    if (hook.lifecycle == _Lifecycle.beforeDispose) hook.fun();
    super.dispose();
    if (hook.lifecycle == _Lifecycle.dispose) hook.fun();
  }

  @override
  void build(BuildContext context) {}
}
