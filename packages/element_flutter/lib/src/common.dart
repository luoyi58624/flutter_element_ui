import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// 将回调函数添加到下一帧执行
void nextTick(VoidCallback fun) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    fun();
  });
}

/// 延迟指定时间执行函数，单位：毫秒
Timer setTimeout(void Function() fun, int wait) {
  return Timer(Duration(milliseconds: wait), fun);
}

/// 每隔一段时间执行函数，单位：毫秒
Timer setInterval(void Function() fun, int wait) {
  return Timer.periodic(Duration(milliseconds: wait), (e) {
    fun();
  });
}

/// 全局 [TickerProvider] 的实现类，通常用于 [AnimationController] 所需要的 vsync 参数，
/// 与 [SingleTickerProviderStateMixin] 区别在于：
/// * 后者编写了详细的 assert 断言警告，帮你规避一些错误；
/// * 后者允许你使用 [TickerMode] 控制子树动画运行；
///
/// 所以，当你使用全局 [vsync] 时需要注意这些局限性：
/// * 时刻记得在 dispose 前销毁动画控制器；
/// * 不要将它用于持久动画，使用 mixin 可以控制动画开启、暂停，例如当前路由页面不可见时动画被会暂停优化资源；
const vsync = _TickerProvider();

/// [Ticker] 的作用在于，它会跟随屏幕刷新率来执行回调，运行效率比定时器更高
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
