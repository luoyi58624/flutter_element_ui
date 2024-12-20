part of 'index.dart';

class _ElScrollbarState extends State<ElScrollbar>
    with SingleTickerProviderStateMixin, _ElScrollbarMixin, _RawScrollbarMixin {
  void handleHoverEnter(PointerEnterEvent event) {
    if (hasHover == false) {
      hasHover = true;
      // 如果是在拖拽状态下鼠标重新进入滚动区域，需要重新判断是否处于滚动条上
      if (isDragScroll) {
        if (isPointerOverThumb(event.position, event.kind)) {
          changeColor(widget.thumbActiveColor, widget.thumbColor);
        }
      } else {
        changeColor(defaultThumbColor, widget.thumbColor);
      }
    }
  }

  void handleHoverExit(PointerExitEvent event) {
    hasHover = false;
    if (isDragScroll) return;
    changeColor(widget.thumbColor, defaultThumbColor);
  }

  /// 开始拖动滚动条
  @override
  void handleThumbPressStart(Offset localPosition) {
    super.handleThumbPressStart(localPosition);

    isDragScroll = true;
    changeColor(widget.thumbColor, widget.thumbActiveColor);
  }

  /// 结束拖动滚动条
  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    super.handleThumbPressEnd(localPosition, velocity);

    if (widget.mode == ElScrollbarMode.onlyScrolling) {
      changeColor(widget.thumbActiveColor, widget.thumbColor);
    } else {
      // 短暂延迟一段时间执行结束逻辑，因为需要依赖 hasHover 判断鼠标是否还在当前滚动区域
      setTimeout(() {
        isDragScroll = false;
        if (hasHover) {
          changeColor(widget.thumbActiveColor, widget.thumbColor);
        } else {
          changeColor(widget.thumbActiveColor, defaultThumbColor);
        }
      }, 16);
    }
  }

  /// 隐藏滚动中的滚动条，如果滚动停止超过一段时间，将隐藏它
  Timer? _hideScrollingTimer;

  void _cancelHideScrollingTimer() {
    if (_hideScrollingTimer != null) {
      _hideScrollingTimer!.cancel();
      _hideScrollingTimer = null;
    }
  }

  /// 延迟清除 [color1]、[color2]
  Timer? _delayCleanColor;

  void _cancelDelayCleanColor() {
    if (_delayCleanColor != null) {
      _delayCleanColor!.cancel();
      _delayCleanColor = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget result = widget.child;
    if (widget.mode == ElScrollbarMode.hidden) return result;

    updateScrollbarPainter();

    result = CustomPaint(
      key: _scrollbarPainterKey,
      foregroundPainter: scrollbarPainter,
      child: RepaintBoundary(child: result),
    );

    if (widget.mode == ElScrollbarMode.hover) {
      result = MouseRegion(
        onEnter: handleHoverEnter,
        onExit: handleHoverExit,
        child: result,
      );
    } else if (widget.mode == ElScrollbarMode.onlyScrolling) {
      result = NotificationListener<ScrollNotification>(
        onNotification: (e) {
          _cancelHideScrollingTimer();
          _cancelDelayCleanColor();
          _hideScrollingTimer = setTimeout(
            () {
              _hideScrollingTimer = null;
              changeColor(widget.thumbColor, defaultThumbColor);
              _delayCleanColor = setTimeout(() {
                _delayCleanColor = null;
                color1 = null;
                color2 = null;
              }, widget.fadeDuration.inMilliseconds);
            },
            widget.timeToFade.inMilliseconds,
          );
          if (color1 == null && color2 == null) {
            changeColor(defaultThumbColor, widget.thumbColor);
          }
          return false;
        },
        child: result,
      );
    }

    if (widget.interactive) {
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
        child: Listener(
          onPointerSignal: _receivedPointerSignal,
          child: result,
        ),
      ),
    );

    return result;
  }
}
