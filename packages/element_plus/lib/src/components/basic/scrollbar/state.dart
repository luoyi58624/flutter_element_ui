part of 'index.dart';

class _ElScrollbarState extends State<ElScrollbar>
    with SingleTickerProviderStateMixin, _ElScrollbarMixin, _RawScrollbarMixin {
  @override
  Widget build(BuildContext context) {
    if (widget.mode == ElScrollbarMode.hidden) return widget.child;

    updateScrollbarPainter();
    Widget result = CustomPaint(
      key: _scrollbarPainterKey,
      foregroundPainter: scrollbarPainter,
      child: RepaintBoundary(child: widget.child),
    );

    if (widget.mode == ElScrollbarMode.hover) {
      result = MouseRegion(
        onEnter: (event) {
          if (isHover) {
            isHover = true;
            // 如果是在拖拽状态下鼠标重新进入滚动区域，需要重新判断是否处于
            if (isDragScroll) {
              if (isPointerOverThumb(event.position, event.kind)) {
                isScrollbarHover = true;
              }
            } else {
              changeColor(hideThumbColor, hoverColor);
            }
          }
        },
        child: result,
      );
    } else if (widget.mode == ElScrollbarMode.always) {
    } else if (widget.mode == ElScrollbarMode.onlyScrolling) {}

    if (enableGestures) {
      result = RawGestureDetector(
        key: _gestureDetectorKey,
        gestures: _gestures,
        child: result,
      );
    }
    result = NotificationListener<ScrollMetricsNotification>(
      onNotification: _handleScrollMetricsNotification,
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: result,
      ),
    );

    return result;
  }
}
