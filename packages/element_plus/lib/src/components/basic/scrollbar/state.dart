part of 'index.dart';

const double _defaultThickness = 6.0;
const Radius _defaultRadius = Radius.circular(3.0);
const int _animationDuration = 200;

/// 延迟激活滚动条高亮时间，防止鼠标快速划过导致滚动条出现轻微闪动
const int _delayActiveDuration = 100;

class _ElScrollbarState extends State<ElScrollbar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation animation;
  late ScrollbarPainter scrollbarPainter;
  final GlobalKey _scrollbarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initScrollbar();
    controller = AnimationController(
      vsync: this,
      duration: 200.ms,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.forward();
  }

  @override
  void didUpdateWidget(covariant ElScrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateScrollbar();
  }

  @override
  void dispose() {
    super.dispose();
    scrollbarPainter.dispose();
  }

  void _initScrollbar() {
    scrollbarPainter = ScrollbarPainter(
      color: widget.thumbColor,
      fadeoutOpacityAnimation: animation,
      trackColor: widget.showTrack
          ? (widget.trackColor ??
              (context.isDark ? Colors.black : Colors.white))
          : Colors.transparent,
      trackBorderColor: widget.showTrack
          ? (widget.trackBorderColor ??
              (context.isDark ? Colors.black : Colors.white))
          : Colors.transparent,
      textDirection: Directionality.of(context),
      thickness: widget.thickness,
      radius: widget.radius,
      minLength: widget.minLength,
      mainAxisMargin: widget.mainAxisMargin,
      crossAxisMargin: widget.crossAxisMargin,
      ignorePointer: widget.ignorePointer,
    );
  }

  /// 更新滚动条样式
  void updateScrollbar() {
    scrollbarPainter
      ..color = widget.thumbColor
      ..trackColor = widget.showTrack
          ? (widget.trackColor ??
              (context.isDark ? Colors.black : Colors.white))
          : Colors.transparent
      ..trackBorderColor = widget.showTrack
          ? (widget.trackBorderColor ??
              (context.isDark ? Colors.black : Colors.white))
          : Colors.transparent
      ..textDirection = Directionality.of(context)
      ..thickness = widget.thickness
      ..radius = widget.radius
      ..minLength = widget.minLength
      ..mainAxisMargin = widget.mainAxisMargin
      ..crossAxisMargin = widget.crossAxisMargin
      ..ignorePointer = widget.ignorePointer;
  }

  /// 判断鼠标指针是否进入滚动条区域
  bool isPointerOverScrollbar(Offset position, PointerDeviceKind kind,
      {bool forHover = false}) {
    final Offset localOffset = _getLocalOffset(_scrollbarKey, position);
    return scrollbarPainter.hitTestInteractive(localOffset, kind,
        forHover: true);
  }

  void handleHover(PointerHoverEvent event) {
    if (isPointerOverScrollbar(event.position, event.kind, forHover: true)) {}
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mode == ElScrollbarMode.hidden) return widget.child;

    Widget result = CustomPaint(
      key: _scrollbarKey,
      foregroundPainter: scrollbarPainter,
      child: RepaintBoundary(child: widget.child),
    );

    if (widget.mode == ElScrollbarMode.hover) {
      result = MouseRegion(
        onHover: (event) {
          switch (event.kind) {
            case PointerDeviceKind.mouse:
            case PointerDeviceKind.trackpad:
              handleHover(event);
            case PointerDeviceKind.stylus:
            case PointerDeviceKind.invertedStylus:
            case PointerDeviceKind.unknown:
            case PointerDeviceKind.touch:
              break;
          }
        },
        child: result,
      );
    }

    result = NotificationListener<ScrollNotification>(
      onNotification: (e) {
        scrollbarPainter.update(e.metrics, AxisDirection.down);
        return false;
      },
      child: result,
    );

    return result;
  }
}
