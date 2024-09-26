part of 'index.dart';

class ElAppState extends State<ElApp> {
  Duration? _globalThemeDuration;
  Curve? _globalThemeCurve;
  Timer? _timer;

  @override
  void didUpdateWidget(covariant ElApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.brightness != oldWidget.brightness) {
      _changeTheme();
    }
  }

  /// 当亮度发生变化时，会设置全局主题变更持续时间和动画曲线，这样可以同步整体页面动画过渡效果
  void _changeTheme() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _globalThemeDuration = widget.config.themeDuration;
    _globalThemeCurve = widget.config.themeCurve;
    _timer = () {
      if (mounted) {
        setState(() {
          _globalThemeDuration = null;
          _globalThemeCurve = null;
          _timer = null;
        });
      }
    }.delay(max(500, widget.config.themeDuration.inMilliseconds));
  }

  bool get isDark => widget.brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    Brightness $brightness =
        widget.brightness ?? MediaQuery.platformBrightnessOf(context);

    // 构建默认的文本样式
    var $textStyle = ElFont.defaultTextStyle
        .copyWith(
        fontWeight: ElFont.normal,
        color: $brightness == Brightness.dark
            ? widget.darkTheme.colors.text
            : widget.theme.colors.text)
        .merge(widget.textStyle);

    // 如果未设置字体大小，则根据平台应用设置不同尺寸的字体，移动端使用 15px，桌面端使用 16px
    if ($textStyle.fontSize == null) {
      $textStyle = $textStyle.copyWith(fontSize: context.sm ? 15 : 16);
    }

    return _AppInheritedWidget(
      AppData(
        brightness: $brightness,
        theme: widget.theme,
        darkTheme: widget.darkTheme,
        config: widget.config,
        textStyle: $textStyle,
        globalThemeDuration: _globalThemeDuration,
        globalThemeCurve: _globalThemeCurve,
      ),
      widget.scrollBehavior,
      child: widget.child,
    );
  }
}
