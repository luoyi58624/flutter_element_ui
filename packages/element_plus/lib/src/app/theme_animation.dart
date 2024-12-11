part of 'index.dart';

/// 切换暗黑模式时禁止所有动画过渡
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
  Duration? _themeDuration;
  Timer? _timer;

  @override
  void didUpdateWidget(covariant _SwitchThemeAnimation oldWidget) {
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
