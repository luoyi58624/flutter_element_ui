import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// [TickerProvider] 实现类，作用是创建 [Ticker] 对象，[Ticker] 的作用是根据屏幕刷新信号来生成回调通知，
/// 它通常用于 [AnimationController] 所需要的 vsync 参数。
///
/// 注意：记得在 dispose 中销毁动画控制器。
const vsync = _TickerProvider();

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
