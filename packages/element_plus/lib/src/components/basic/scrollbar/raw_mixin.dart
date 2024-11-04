part of 'index.dart';

/// 之前是通过继承 [RawScrollbar] 实现自定义滚动条，但有些细节没法处理，所以索性直接修改官方源码
mixin _RawScrollbarMixin<T extends ElScrollbar> on _ElScrollbarMixin<T> {
  Offset? _startDragScrollbarAxisOffset;
  Offset? _lastDragUpdateOffset;
  double? _startDragThumbOffset;
  ScrollController? _cachedController;
  final GlobalKey _scrollbarPainterKey = GlobalKey();
  Drag? _thumbDrag;
  bool _maxScrollExtentPermitsScrolling = false;
  ScrollHoldController? _thumbHold;
  Axis? _axis;
  final GlobalKey<RawGestureDetectorState> _gestureDetectorKey =
      GlobalKey<RawGestureDetectorState>();

  ScrollController? get _effectiveScrollController =>
      widget.controller ?? PrimaryScrollController.maybeOf(context);

  /// Returns the [Axis] of the child scroll view, or null if the
  /// we haven't seen a ScrollMetrics notification yet.
  @protected
  Axis? getScrollbarDirection() => _axis;

  void _disposeThumbDrag() {
    _thumbDrag = null;
  }

  void _disposeThumbHold() {
    _thumbHold = null;
  }

  // Given the drag's localPosition (see handleThumbPressUpdate) compute the
  // scroll position delta in the scroll axis direction. Deal with the complications
  // arising from scroll metrics changes that have occurred since the last
  // drag update and the need to prevent overscrolling on some platforms.
  double? _getPrimaryDelta(Offset localPosition) {
    assert(_cachedController != null);
    assert(_startDragScrollbarAxisOffset != null);
    assert(_lastDragUpdateOffset != null);
    assert(_startDragThumbOffset != null);

    final ScrollPosition position = _cachedController!.position;
    late double primaryDeltaFromDragStart;
    late double primaryDeltaFromLastDragUpdate;
    switch (position.axisDirection) {
      case AxisDirection.up:
        primaryDeltaFromDragStart =
            _startDragScrollbarAxisOffset!.dy - localPosition.dy;
        primaryDeltaFromLastDragUpdate =
            _lastDragUpdateOffset!.dy - localPosition.dy;
      case AxisDirection.right:
        primaryDeltaFromDragStart =
            localPosition.dx - _startDragScrollbarAxisOffset!.dx;
        primaryDeltaFromLastDragUpdate =
            localPosition.dx - _lastDragUpdateOffset!.dx;
      case AxisDirection.down:
        primaryDeltaFromDragStart =
            localPosition.dy - _startDragScrollbarAxisOffset!.dy;
        primaryDeltaFromLastDragUpdate =
            localPosition.dy - _lastDragUpdateOffset!.dy;
      case AxisDirection.left:
        primaryDeltaFromDragStart =
            _startDragScrollbarAxisOffset!.dx - localPosition.dx;
        primaryDeltaFromLastDragUpdate =
            _lastDragUpdateOffset!.dx - localPosition.dx;
    }

    // Convert primaryDelta, the amount that the scrollbar moved since the last
    // time when drag started or last updated, into the coordinate space of the scroll
    // position.
    double scrollOffsetGlobal = scrollbarPainter
        .getTrackToScroll(_startDragThumbOffset! + primaryDeltaFromDragStart);

    if (primaryDeltaFromDragStart > 0 && scrollOffsetGlobal < position.pixels ||
        primaryDeltaFromDragStart < 0 && scrollOffsetGlobal > position.pixels) {
      // Adjust the position value if the scrolling direction conflicts with
      // the dragging direction due to scroll metrics shrink.
      scrollOffsetGlobal = position.pixels +
          scrollbarPainter.getTrackToScroll(primaryDeltaFromLastDragUpdate);
    }
    if (scrollOffsetGlobal != position.pixels) {
      // Ensure we don't drag into overscroll if the physics do not allow it.
      final double physicsAdjustment = position.physics
          .applyBoundaryConditions(position, scrollOffsetGlobal);
      double newPosition = scrollOffsetGlobal - physicsAdjustment;

      // The physics may allow overscroll when actually *scrolling*, but
      // dragging on the scrollbar does not always allow us to enter overscroll.
      switch (ScrollConfiguration.of(context).getPlatform(context)) {
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.macOS:
        case TargetPlatform.windows:
          newPosition = clampDouble(
              newPosition, position.minScrollExtent, position.maxScrollExtent);
        case TargetPlatform.iOS:
        case TargetPlatform.android:
        // We can only drag the scrollbar into overscroll on mobile
        // platforms, and only then if the physics allow it.
      }
      final bool isReversed = axisDirectionIsReversed(position.axisDirection);
      return isReversed
          ? newPosition - position.pixels
          : position.pixels - newPosition;
    }
    return null;
  }

  /// Handler called when a press on the scrollbar thumb has been recognized.
  ///
  /// Cancels the [Timer] associated with the fade animation of the scrollbar.
  @protected
  @mustCallSuper
  void handleThumbPress() {
    _cachedController = _effectiveScrollController;
    if (getScrollbarDirection() == null) {
      return;
    }
    _thumbHold = _cachedController!.position.hold(_disposeThumbHold);
  }

  /// Handler called when a long press gesture has started.
  ///
  /// Begins the fade out animation and creates the thumb's DragScrollController.
  @protected
  @mustCallSuper
  void handleThumbPressStart(Offset localPosition) {
    final Axis? direction = getScrollbarDirection();
    if (direction == null) {
      return;
    }

    assert(_thumbDrag == null);
    final ScrollPosition position = _cachedController!.position;
    final RenderBox renderBox =
        _scrollbarPainterKey.currentContext!.findRenderObject()! as RenderBox;
    final DragStartDetails details = DragStartDetails(
      localPosition: localPosition,
      globalPosition: renderBox.localToGlobal(localPosition),
    );
    _thumbDrag = position.drag(details, _disposeThumbDrag);
    assert(_thumbDrag != null);
    assert(_thumbHold == null);

    _startDragScrollbarAxisOffset = localPosition;
    _lastDragUpdateOffset = localPosition;
    _startDragThumbOffset = scrollbarPainter.getThumbScrollOffset();
  }

  /// Handler called when a currently active long press gesture moves.
  ///
  /// Updates the position of the child scrollable via the _drag ScrollDragController.
  @protected
  @mustCallSuper
  void handleThumbPressUpdate(Offset localPosition) {
    if (_lastDragUpdateOffset == localPosition) {
      return;
    }
    final ScrollPosition position = _cachedController!.position;
    if (!position.physics.shouldAcceptUserOffset(position)) {
      return;
    }
    final Axis? direction = getScrollbarDirection();
    if (direction == null) {
      return;
    }
    // _thumbDrag might be null if the drag activity ended and called _disposeThumbDrag.
    assert(_thumbHold == null || _thumbDrag == null);
    if (_thumbDrag == null) {
      return;
    }

    final double? primaryDelta = _getPrimaryDelta(localPosition);
    if (primaryDelta == null) {
      return;
    }

    final Offset delta = switch (direction) {
      Axis.horizontal => Offset(primaryDelta, 0),
      Axis.vertical => Offset(0, primaryDelta),
    };

    final RenderBox renderBox =
        _scrollbarPainterKey.currentContext!.findRenderObject()! as RenderBox;
    final DragUpdateDetails scrollDetails = DragUpdateDetails(
      delta: delta,
      primaryDelta: primaryDelta,
      globalPosition: renderBox.localToGlobal(localPosition),
      localPosition: localPosition,
    );
    _thumbDrag!.update(scrollDetails);
    _lastDragUpdateOffset = localPosition;
  }

  /// Handler called when a long press has ended.
  @protected
  @mustCallSuper
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    final Axis? direction = getScrollbarDirection();
    if (direction == null) {
      return;
    }
    _cachedController = null;
    _lastDragUpdateOffset = null;

    // _thumbDrag might be null if the drag activity ended and called _disposeThumbDrag.
    assert(_thumbHold == null || _thumbDrag == null);
    if (_thumbDrag == null) {
      return;
    }

    // On mobile platforms flinging the scrollbar thumb causes a ballistic
    // scroll, just like it does via a touch drag. Likewise for desktops when
    // dragging on the trackpad or with a stylus.
    final TargetPlatform platform =
        ScrollConfiguration.of(context).getPlatform(context);
    final Velocity adjustedVelocity = switch (platform) {
      TargetPlatform.iOS || TargetPlatform.android => -velocity,
      _ => Velocity.zero,
    };
    final RenderBox renderBox =
        _scrollbarPainterKey.currentContext!.findRenderObject()! as RenderBox;
    final DragEndDetails details = DragEndDetails(
      localPosition: localPosition,
      globalPosition: renderBox.localToGlobal(localPosition),
      velocity: adjustedVelocity,
      primaryVelocity: switch (direction) {
        Axis.horizontal => adjustedVelocity.pixelsPerSecond.dx,
        Axis.vertical => adjustedVelocity.pixelsPerSecond.dy,
      },
    );

    _thumbDrag?.end(details);
    assert(_thumbDrag == null);

    _startDragScrollbarAxisOffset = null;
    _lastDragUpdateOffset = null;
    _startDragThumbOffset = null;
    _cachedController = null;
  }

  void _handleTrackTapDown(TapDownDetails details) {
    _cachedController = _effectiveScrollController;

    final ScrollPosition position = _cachedController!.position;
    if (!position.physics.shouldAcceptUserOffset(position)) {
      return;
    }

    final double scrollableExtent = scrollbarPainter._totalContentExtent;

    final thumbRatio = scrollbarPainter._thumbExtent /
        scrollbarPainter._traversableTrackExtent;

    late double targetOffset;

    switch (axisDirectionToAxis(position.axisDirection)) {
      case Axis.vertical:
        if (details.localPosition.dy > scrollbarPainter._thumbOffset) {
          final tractRatio = details.localPosition.dy /
              scrollbarPainter._traversableTrackExtent;
          targetOffset = math.min(
            scrollableExtent * (tractRatio - thumbRatio / 2),
            position.maxScrollExtent,
          );
        } else {
          final tractRatio = details.localPosition.dy /
              scrollbarPainter._traversableTrackExtent;
          targetOffset = math.max(
            scrollableExtent * (tractRatio - thumbRatio / 2),
            position.minScrollExtent,
          );
        }
      case Axis.horizontal:
        if (details.localPosition.dx > scrollbarPainter._thumbOffset) {
          final tractRatio = details.localPosition.dx /
              scrollbarPainter._traversableTrackExtent;
          targetOffset = math.min(
            scrollableExtent * (tractRatio - thumbRatio / 2),
            position.maxScrollExtent,
          );
        } else {
          final tractRatio = details.localPosition.dx /
              scrollbarPainter._traversableTrackExtent;
          targetOffset = math.max(
            scrollableExtent * (tractRatio - thumbRatio / 2),
            position.minScrollExtent,
          );
        }
    }

    _cachedController!.animateTo(
      targetOffset,
      duration: widget.trackScrollDuration,
      curve: Curves.easeInOut,
    );
  }

  // ScrollController takes precedence over ScrollNotification
  bool _shouldUpdatePainter(Axis notificationAxis) {
    final ScrollController? scrollController = _effectiveScrollController;
    // Only update the painter of this scrollbar if the notification
    // metrics do not conflict with the information we have from the scroll
    // controller.

    // We do not have a scroll controller dictating axis.
    if (scrollController == null) {
      return true;
    }
    // Has more than one attached positions.
    if (scrollController.positions.length > 1) {
      return false;
    }

    return
        // The scroll controller is not attached to a position.
        !scrollController.hasClients
            // The notification matches the scroll controller's axis.
            ||
            scrollController.position.axis == notificationAxis;
  }

  bool _handleScrollMetricsNotification(
      ScrollMetricsNotification notification) {
    if (!defaultScrollNotificationPredicate(notification.asScrollUpdate())) {
      return false;
    }

    final ScrollMetrics metrics = notification.metrics;
    if (_shouldUpdatePainter(metrics.axis)) {
      scrollbarPainter.update(metrics, metrics.axisDirection);
    }
    if (metrics.axis != _axis) {
      setState(() {
        _axis = metrics.axis;
      });
    }
    if (_maxScrollExtentPermitsScrolling !=
        notification.metrics.maxScrollExtent > 0.0) {
      setState(() {
        _maxScrollExtentPermitsScrolling = !_maxScrollExtentPermitsScrolling;
      });
    }

    return false;
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (!defaultScrollNotificationPredicate(notification)) {
      return false;
    }

    final ScrollMetrics metrics = notification.metrics;
    if (metrics.maxScrollExtent <= metrics.minScrollExtent) {
      if (_shouldUpdatePainter(metrics.axis)) {
        scrollbarPainter.update(metrics, metrics.axisDirection);
      }
      return false;
    }

    if (notification is ScrollUpdateNotification ||
        notification is OverscrollNotification) {
      if (_shouldUpdatePainter(metrics.axis)) {
        scrollbarPainter.update(metrics, metrics.axisDirection);
      }
    }
    return false;
  }

  void _handleThumbDragDown(DragDownDetails details) {
    handleThumbPress();
  }

  // The protected RawScrollbar API methods - handleThumbPressStart,
  // handleThumbPressUpdate, handleThumbPressEnd - all depend on a
  // localPosition parameter that defines the event's location relative
  // to the scrollbar. Ensure that the localPosition is reported consistently,
  // even if the source of the event is a trackpad or a stylus.
  Offset _globalToScrollbar(Offset offset) {
    final RenderBox renderBox =
        _scrollbarPainterKey.currentContext!.findRenderObject()! as RenderBox;
    return renderBox.globalToLocal(offset);
  }

  void _handleThumbDragStart(DragStartDetails details) {
    // 拖拽滚动时设置全局默认光标，这样可以杜绝鼠标在拖拽过程中触发页面元素的 hover 事件
    el.cursor.add();
    handleThumbPressStart(_globalToScrollbar(details.globalPosition));
  }

  void _handleThumbDragUpdate(DragUpdateDetails details) {
    handleThumbPressUpdate(_globalToScrollbar(details.globalPosition));
  }

  void _handleThumbDragEnd(DragEndDetails details) {
    el.cursor.remove();
    handleThumbPressEnd(
        _globalToScrollbar(details.globalPosition), details.velocity);
  }

  void _handleThumbDragCancel() {
    el.cursor.remove();
    if (_gestureDetectorKey.currentContext == null) {
      // The cancel was caused by the GestureDetector getting disposed, which
      // means we will get disposed momentarily as well and shouldn't do
      // any work.
      return;
    }
    // _thumbHold might be null if the drag started.
    // _thumbDrag might be null if the drag activity ended and called _disposeThumbDrag.
    assert(_thumbHold == null || _thumbDrag == null);
    _thumbHold?.cancel();
    _thumbDrag?.cancel();
    assert(_thumbHold == null);
    assert(_thumbDrag == null);
  }

  void _initThumbDragGestureRecognizer(DragGestureRecognizer instance) {
    instance.onDown = _handleThumbDragDown;
    instance.onStart = _handleThumbDragStart;
    instance.onUpdate = _handleThumbDragUpdate;
    instance.onEnd = _handleThumbDragEnd;
    instance.onCancel = _handleThumbDragCancel;
    instance.gestureSettings = const DeviceGestureSettings(touchSlop: 0);
    instance.dragStartBehavior = DragStartBehavior.down;
  }

  bool _canHandleScrollGestures() {
    return widget.interactive &&
        _effectiveScrollController != null &&
        _effectiveScrollController!.positions.length == 1 &&
        _effectiveScrollController!.position.hasContentDimensions &&
        _effectiveScrollController!.position.maxScrollExtent > 0.0;
  }

  Map<Type, GestureRecognizerFactory> get _gestures {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{};
    if (!_canHandleScrollGestures()) {
      return gestures;
    }

    switch (_axis) {
      case Axis.horizontal:
        gestures[_HorizontalThumbDragGestureRecognizer] =
            GestureRecognizerFactoryWithHandlers<
                _HorizontalThumbDragGestureRecognizer>(
          () => _HorizontalThumbDragGestureRecognizer(
            debugOwner: this,
            customPaintKey: _scrollbarPainterKey,
          ),
          _initThumbDragGestureRecognizer,
        );
      case Axis.vertical:
        gestures[_VerticalThumbDragGestureRecognizer] =
            GestureRecognizerFactoryWithHandlers<
                _VerticalThumbDragGestureRecognizer>(
          () => _VerticalThumbDragGestureRecognizer(
            debugOwner: this,
            customPaintKey: _scrollbarPainterKey,
          ),
          _initThumbDragGestureRecognizer,
        );
      case null:
        return gestures;
    }

    gestures[_TrackTapGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<_TrackTapGestureRecognizer>(
      () => _TrackTapGestureRecognizer(
        debugOwner: this,
        customPaintKey: _scrollbarPainterKey,
      ),
      (_TrackTapGestureRecognizer instance) {
        if (widget.trackInteractive) {
          instance.onTapDown = _handleTrackTapDown;
        } else {
          instance.onTapDown = null;
        }
      },
    );

    return gestures;
  }

  /// Returns true if the provided [Offset] is located over the track of the
  /// [RawScrollbar].
  ///
  /// Excludes the [RawScrollbar] thumb.
  @protected
  bool isPointerOverTrack(Offset position, PointerDeviceKind kind) {
    if (_scrollbarPainterKey.currentContext == null) {
      return false;
    }
    final Offset localOffset = _getLocalOffset(_scrollbarPainterKey, position);
    return scrollbarPainter.hitTestInteractive(localOffset, kind) &&
        !scrollbarPainter.hitTestOnlyThumbInteractive(localOffset, kind);
  }

  /// Returns true if the provided [Offset] is located over the thumb of the
  /// [RawScrollbar].
  @protected
  bool isPointerOverThumb(Offset position, PointerDeviceKind kind) {
    if (_scrollbarPainterKey.currentContext == null) {
      return false;
    }
    final Offset localOffset = _getLocalOffset(_scrollbarPainterKey, position);
    return scrollbarPainter.hitTestOnlyThumbInteractive(localOffset, kind);
  }

  /// 判断鼠标指针是否进入滚动条区域
  bool isPointerOverScrollbar(Offset position, PointerDeviceKind kind,
      {bool forHover = false}) {
    if (_scrollbarPainterKey.currentContext == null) {
      return false;
    }
    final Offset localOffset = _getLocalOffset(_scrollbarPainterKey, position);
    return scrollbarPainter.hitTestInteractive(localOffset, kind,
        forHover: true);
  }

  // Returns the delta that should result from applying [event] with axis and
  // direction taken into account.
  double _pointerSignalEventDelta(PointerScrollEvent event) {
    assert(_cachedController != null);
    double delta = _cachedController!.position.axis == Axis.horizontal
        ? event.scrollDelta.dx
        : event.scrollDelta.dy;

    if (axisDirectionIsReversed(_cachedController!.position.axisDirection)) {
      delta *= -1;
    }
    return delta;
  }

  // Returns the offset that should result from applying [event] to the current
  // position, taking min/max scroll extent into account.
  double _targetScrollOffsetForPointerScroll(double delta) {
    assert(_cachedController != null);
    return math.min(
      math.max(_cachedController!.position.pixels + delta,
          _cachedController!.position.minScrollExtent),
      _cachedController!.position.maxScrollExtent,
    );
  }

  void _handlePointerScroll(PointerEvent event) {
    assert(event is PointerScrollEvent);
    _cachedController = _effectiveScrollController;
    final double delta = _pointerSignalEventDelta(event as PointerScrollEvent);
    final double targetScrollOffset =
        _targetScrollOffsetForPointerScroll(delta);
    if (delta != 0.0 &&
        targetScrollOffset != _cachedController!.position.pixels) {
      _cachedController!.position.pointerScroll(delta);
    }
  }

  void _receivedPointerSignal(PointerSignalEvent event) {
    _cachedController = _effectiveScrollController;
    // Only try to scroll if the bar absorb the hit test.
    if ((scrollbarPainter.hitTest(event.localPosition) ?? false) &&
        _cachedController != null &&
        _cachedController!.hasClients &&
        (_thumbDrag == null || kIsWeb)) {
      final ScrollPosition position = _cachedController!.position;
      if (event is PointerScrollEvent) {
        if (!position.physics.shouldAcceptUserOffset(position)) {
          return;
        }
        final double delta = _pointerSignalEventDelta(event);
        final double targetScrollOffset =
            _targetScrollOffsetForPointerScroll(delta);
        if (delta != 0.0 && targetScrollOffset != position.pixels) {
          GestureBinding.instance.pointerSignalResolver
              .register(event, _handlePointerScroll);
        }
      } else if (event is PointerScrollInertiaCancelEvent) {
        position.jumpTo(position.pixels);
        // Don't use the pointer signal resolver, all hit-tested scrollables should stop.
      }
    }
  }
}

Offset _getLocalOffset(GlobalKey scrollbarPainterKey, Offset position) {
  final RenderBox renderBox =
      scrollbarPainterKey.currentContext!.findRenderObject()! as RenderBox;
  return renderBox.globalToLocal(position);
}

bool _isThumbEvent(GlobalKey customPaintKey, PointerEvent event) {
  if (customPaintKey.currentContext == null) {
    return false;
  }

  final CustomPaint customPaint =
      customPaintKey.currentContext!.widget as CustomPaint;
  final _ScrollbarPainter painter =
      customPaint.foregroundPainter! as _ScrollbarPainter;
  final Offset localOffset = _getLocalOffset(customPaintKey, event.position);
  return painter.hitTestOnlyThumbInteractive(localOffset, event.kind);
}

bool _isTrackEvent(GlobalKey customPaintKey, PointerEvent event) {
  if (customPaintKey.currentContext == null) {
    return false;
  }
  final CustomPaint customPaint =
      customPaintKey.currentContext!.widget as CustomPaint;
  final _ScrollbarPainter painter =
      customPaint.foregroundPainter! as _ScrollbarPainter;
  final Offset localOffset = _getLocalOffset(customPaintKey, event.position);
  final PointerDeviceKind kind = event.kind;
  return painter.hitTestInteractive(localOffset, kind) &&
      !painter.hitTestOnlyThumbInteractive(localOffset, kind);
}

class _TrackTapGestureRecognizer extends TapGestureRecognizer {
  _TrackTapGestureRecognizer({
    required super.debugOwner,
    required GlobalKey customPaintKey,
  }) : _customPaintKey = customPaintKey;

  final GlobalKey _customPaintKey;

  @override
  bool isPointerAllowed(PointerDownEvent event) {
    return _isTrackEvent(_customPaintKey, event) &&
        super.isPointerAllowed(event);
  }
}

class _VerticalThumbDragGestureRecognizer
    extends VerticalDragGestureRecognizer {
  _VerticalThumbDragGestureRecognizer({
    required Object super.debugOwner,
    required GlobalKey customPaintKey,
  }) : _customPaintKey = customPaintKey;

  final GlobalKey _customPaintKey;

  @override
  bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event) {
    return false;
  }

  @override
  bool isPointerAllowed(PointerEvent event) {
    // i(_isThumbEvent(_customPaintKey, event));
    return _isThumbEvent(_customPaintKey, event) &&
        super.isPointerAllowed(event);
  }
}

class _HorizontalThumbDragGestureRecognizer
    extends HorizontalDragGestureRecognizer {
  _HorizontalThumbDragGestureRecognizer({
    required Object super.debugOwner,
    required GlobalKey customPaintKey,
  }) : _customPaintKey = customPaintKey;

  final GlobalKey _customPaintKey;

  @override
  bool isPointerPanZoomAllowed(PointerPanZoomStartEvent event) {
    return false;
  }

  @override
  bool isPointerAllowed(PointerEvent event) {
    return _isThumbEvent(_customPaintKey, event) &&
        super.isPointerAllowed(event);
  }
}
