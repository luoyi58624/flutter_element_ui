part of flutter_element_ui;

Timer? _timer;

class ElTapBuilder extends HookWidget {
  /// 按下事件构造器
  const ElTapBuilder({
    super.key,
    required this.builder,
    this.onTap,
    this.delay = 0,
    this.disabled = false,
  }) : assert(delay >= 0);

  final Widget Function(bool isTap) builder;

  final GestureTapCallback? onTap;

  /// 延迟多少毫秒更新点击状态
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
                  DartUtil.delay(() => update(isTap, true), 16);
                } else {
                  update(isTap, true);
                }
              },
        onTapUp: disabled
            ? null
            : (e) {
                _timer = DartUtil.delay(() {
                  update(isTap, false);
                  _timer = null;
                }, delay);
              },
        onTapCancel: disabled
            ? null
            : () {
                _timer = DartUtil.delay(() {
                  update(isTap, false);
                  _timer = null;
                }, delay);
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
