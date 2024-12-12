part of 'index.dart';

/// 更新全局 [ElThemeData] 时禁止所有组件的动画过渡，例如：切换暗黑模式。
///
/// * 这样做的好处是页面元素过渡一致，每个组件的过渡时间不可能完全一致，有些需要 100 毫秒，有些则是 300 毫秒，
/// 如果不禁止动画时间，那么切换全局主题时每个动画组件元素状态将必定不一致。
/// * 然后是在复杂页面上性能更高，因为动画意味着每一帧都需要重建 [Widget]，更新全局主题意味着每一帧都要重建大量小部件，
/// 很容易引起卡顿。
/// * 主题设计可以更简单，官方实现的 [ThemeData] 为了支持线性插值，对每一个组件的主题都编写了大量的 lerp 函数，
/// 所做的这一切就只是为了在更新主题时能够拥有过渡效果，投入与产出性价比非常低。
class _SwitchThemeAnimation extends StatefulWidget {
  const _SwitchThemeAnimation({
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElThemeData data;

  @override
  State<_SwitchThemeAnimation> createState() => _ThemeAnimationState();
}

class _ThemeAnimationState extends State<_SwitchThemeAnimation> {
  /// 全局主题过渡持续时间，当组件通过 context.elDuration() 包裹自定义 Duration 对象时，
  /// 组件的过渡持续时间就会与 [_themeDuration] 进行关联，平常状态下使用自定义的过渡时间，
  /// 当更新全局主题时组件过渡时间为 0
  Duration? _themeDuration;
  Timer? _timer;

  @override
  void didUpdateWidget(covariant _SwitchThemeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _changeTheme();
    }
  }

  /// 当 [ElThemeData] 主题配置不一致时会触发此方法，此方法目的很简单，就是先将 [_themeDuration] 设置为 0，
  /// 然后在短暂延迟后重置 [_themeDuration]，所以每次更新 [ElThemeData] 会引起第二次重建，
  /// 但与全局动画所造成几十次重建相比，这显然便宜了很多。
  void _changeTheme() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _themeDuration = Duration.zero;
    _timer = setTimeout(() {
      if (mounted) {
        setState(() {
          _themeDuration = null;
          _timer = null;
        });
      }
    }, 100);
  }

  @override
  Widget build(BuildContext context) {
    return _SwitchThemeAnimationInheritedWidget(
      _themeDuration,
      child: widget.child,
    );
  }
}

class _SwitchThemeAnimationInheritedWidget extends InheritedWidget {
  const _SwitchThemeAnimationInheritedWidget(
    this.themeDuration, {
    required super.child,
  });

  final Duration? themeDuration;

  static _SwitchThemeAnimationInheritedWidget of(BuildContext context) {
    final _SwitchThemeAnimationInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<
            _SwitchThemeAnimationInheritedWidget>();
    return result!;
  }

  @override
  bool updateShouldNotify(_SwitchThemeAnimationInheritedWidget oldWidget) =>
      true;
}
