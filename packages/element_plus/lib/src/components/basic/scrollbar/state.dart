part of 'index.dart';

class _ElScrollbarState extends State<ElScrollbar>
    with SingleTickerProviderStateMixin, _ElScrollbarMixin, _RawScrollbarMixin {
  void handleHoverEnter(PointerEnterEvent event) {
    if (isHover == false) {
      isHover = true;
      // 如果是在拖拽状态下鼠标重新进入滚动区域，需要重新判断是否处于滚动条上
      if (isDragScroll) {
        if (isPointerOverThumb(event.position, event.kind)) {
          isScrollbarHover = true;
        }
      } else {
        changeColor(hideThumbColor, hoverColor);
      }
    }
  }

  void handleHoverExit(PointerExitEvent event) {
    // 离开时一定要先取消延迟激活动画，防止快速将鼠标悬停在滚动条时，又快速离开产生状态bug
    _cancelDelayActiveHover();
    // 将这两种状态重置是必须的，后续的逻辑判断依赖它们
    isHover = false;
    isScrollbarHover = false;
    // 如果是处于拖拽状态便离开滚动区域，那么保存滚动条当前颜色状态，否则隐藏滚动条
    if (isDragScroll) return;
    if (color2 != null) {
      changeColor(color2!, hideThumbColor);
    }
  }

  /// 开始拖动滚动条
  @override
  void handleThumbPressStart(Offset localPosition) {
    super.handleThumbPressStart(localPosition);
    // 拖拽滚动时设置全局默认光标，这样可以杜绝鼠标在拖拽过程中触发页面元素的 hover 事件
    el.cursor.add();
    isDragScroll = true;
    // 处理直接从边缘处立即拖动滚动条
    if (isScrollbarHover == false) {
      isScrollbarHover = true;
      changeColor(isHover ? hoverColor : hideThumbColor, activeColor);
    }
  }

  /// 结束拖动滚动条
  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    super.handleThumbPressEnd(localPosition, velocity);
    el.cursor.remove();
    // 短暂延迟一段时间执行结束逻辑，因为受到 cursor 的影响会导致悬停状态丢失,
    // isScrollbarHover 状态需要在 onEnter 中判断鼠标是否在滚动条上
    setTimeout(() {
      isDragScroll = false;
      if (isScrollbarHover == false) {
        if (isHover) {
          changeColor(activeColor, hoverColor);
        } else {
          changeColor(activeColor, hideThumbColor);
        }
      }
    }, 16);
  }

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
        onEnter: handleHoverEnter,
        onExit: handleHoverExit,
        child: result,
      );
    } else if (widget.mode == ElScrollbarMode.always) {
    } else if (widget.mode == ElScrollbarMode.onlyScrolling) {}

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
        child: result,
      ),
    );

    return result;
  }
}
