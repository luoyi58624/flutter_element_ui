part of 'index.dart';

/// Element UI 全局主题动画小部件，当切换全局主题时，该小部件会先应用 [ElConfigThemeData] 配置的全局主题过渡动画时间、曲线，
/// 用于保证切换主题过渡一致性，然后会触发第二次 build 构建，用于重置过渡时间、曲线
class _ThemeAnimation extends StatefulWidget {
  const _ThemeAnimation({
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElThemeData data;

  @override
  State<_ThemeAnimation> createState() => _ThemeAnimationState();
}

class _ThemeAnimationState extends State<_ThemeAnimation> {
  Duration? _themeDuration;
  Curve? _themeCurve;
  Timer? _timer;

  ElConfigThemeData get config => context.elConfig;

  @override
  void didUpdateWidget(covariant _ThemeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _changeTheme();
    }
  }

  void _changeTheme() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _themeDuration = config.themeDuration;
    _themeCurve = config.themeCurve;
    _timer = setTimeout(() {
      if (mounted) {
        setState(() {
          _themeDuration = null;
          _themeCurve = null;
          _timer = null;
        });
      }
    }, max(500, config.themeDuration.inMilliseconds));
  }

  @override
  Widget build(BuildContext context) {
    return _ThemeAnimationInheritedWidget(
      _themeDuration,
      _themeCurve,
      child: widget.child,
    );
  }
}

class _ThemeAnimationInheritedWidget extends InheritedWidget {
  const _ThemeAnimationInheritedWidget(
    this.themeDuration,
    this.themeCurve, {
    required super.child,
  });

  final Duration? themeDuration;
  final Curve? themeCurve;

  static _ThemeAnimationInheritedWidget of(BuildContext context) {
    final _ThemeAnimationInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_ThemeAnimationInheritedWidget>();
    return result!;
  }

  @override
  bool updateShouldNotify(_ThemeAnimationInheritedWidget oldWidget) => true;
}
