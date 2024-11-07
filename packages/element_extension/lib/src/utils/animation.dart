import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class _TickerProvider implements TickerProvider {
  const _TickerProvider();

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(
      onTick,
      debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null,
    );
  }
}

/// 全局 [Ticker] 构建对象，它用于 [AnimationController] 所需要的 vsync 参数对象。
///
/// 通常来讲它不会导致什么副作用，我翻阅 [AnimationController] 的源码无非就是通过 [TickerProvider] 的实现类创建 [Ticker]，
/// 后续的行为就是操作 _ticker 对象，最后在 dispose 动画控制器时，引用的 _ticker 也会被处理。
///
/// 你唯一需要注意的是记住在 dispose 中销毁动画控制器（调用时机要在 super.dispose 之前），
/// 当你使用 [SingleTickerProviderStateMixin] 会有 assert 断言提示，而这个常量则没有错误提示。
const vsync = _TickerProvider();
