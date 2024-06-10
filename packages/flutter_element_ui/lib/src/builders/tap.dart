import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

Timer? _timer;

class ElTapBuilder extends HookWidget {
  /// 按下事件构造器
  const ElTapBuilder({
    super.key,
    required this.builder,
    this.onTap,
    this.delay = 16,
    this.disabled = false,
  }) : assert(delay >= 0);

  final Widget Function(bool isTap) builder;

  final GestureTapCallback? onTap;

  /// 延迟多少毫秒更新点击状态，默认 16 毫秒。
  ///
  /// 提示：如果在极短的时间内多次调用setState，flutter只会触发一次更新，例如用户手指轻按、鼠标轻点，这里其中的时间间隔极短，
  /// 如果不设置一点延迟，那么依赖点击状态的动画可能会没有反应
  final int delay;

  /// 是否禁用，默认false
  final bool disabled;

  /// 根据上下文获取最近的点击状态
  static bool of(BuildContext context) => _TapInheritedWidget.of(context);

  @override
  Widget build(BuildContext context) {
    final isTap = useState(false);
    return _TapInheritedWidget(
      isTap: isTap.value,
      child: GestureDetector(
        onTap: disabled ? null : onTap,
        onTapDown: disabled
            ? null
            : (e) {
                if (_timer != null) {
                  _timer!.cancel();
                  _timer = null;
                  update(isTap, false);
                  (() => update(isTap, true)).delay(16);
                } else {
                  update(isTap, true);
                }
              },
        onTapUp: disabled
            ? null
            : (e) {
                _timer = () {
                  update(isTap, false);
                  _timer = null;
                }.delay(delay);
              },
        onTapCancel: disabled
            ? null
            : () {
                _timer = () {
                  update(isTap, false);
                  _timer = null;
                }.delay(delay);
              },
        child: builder(isTap.value),
      ),
    );
  }

  void update(ValueNotifier<bool> isTap, bool enabled) {
    if (isTap.value != enabled) isTap.value = enabled;
  }
}

class _TapInheritedWidget extends InheritedWidget {
  const _TapInheritedWidget({
    required super.child,
    required this.isTap,
  });

  final bool isTap;

  static bool of(BuildContext context) {
    final _TapInheritedWidget? result = context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();
    return result == null ? false : result.isTap;
  }

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) {
    return true;
  }
}
