part of 'index.dart';

const _duration = Duration(milliseconds: 250);
const _curve = Curves.easeInOut;

class _ElSliderState extends ElModelValueState<ElSlider, double>
    with SingleTickerProviderStateMixin {
  /// 允许拖拽的最大尺寸
  double? _maxDragSize;

  /// 当前拖拽的物理像素
  late double _currentDragValue;

  /// 轨道圆角
  late BorderRadiusGeometry _trackRadius;

  /// 轨道内边距
  late EdgeInsetsGeometry _trackPadding;

  bool isDrag = false;

  double get sliderValue => _maxDragSize! / widget.max * modelValue;

  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: _duration,
  );
  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    _currentDragValue = modelValue;
    curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: _curve,
    );
  }

  @override
  void didUpdateWidget(covariant ElSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.max != oldWidget.max) {
      _currentDragValue = sliderValue;
      if (widget.max < modelValue) {
        ElUtils.nextTick(() {
          modelValue = widget.max;
          _currentDragValue = sliderValue;
        });
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _startDrag() {
    el.cursor.set(widget.cursor ?? ElCursorUtil.grabbing);
    isDrag = true;
  }

  void _updateDrag(DragUpdateDetails e) {
    _currentDragValue += e.delta.dx;
    modelValue = _calcSliderValue();
  }

  void _endDrag(DragEndDetails e) {
    modelValue = _calcSliderValue();
    if (_currentDragValue < 0) {
      _currentDragValue = 0;
    } else if (_currentDragValue > _maxDragSize!) {
      _currentDragValue = _maxDragSize!;
    }
    setState(() {
      isDrag = false;
    });
    el.cursor.remove();
  }

  void cancelDrag() {
    setState(() {
      isDrag = false;
    });
    el.cursor.remove();
  }

  double _calcSliderValue() {
    late double value;
    if (_currentDragValue <= 0) {
      value = widget.min;
    } else if (_currentDragValue >= _maxDragSize!) {
      value = widget.max;
    } else {
      value = _currentDragValue / _maxDragSize! * widget.max;
    }
    return value;
  }

  @override
  Widget builder(BuildContext context, double value) {
    _trackRadius = widget.disabledThumbRadius
        ? BorderRadius.zero
        : BorderRadius.circular(max(
                max(widget.thumbSize, widget.hoverThumbSize),
                widget.activeThumbSize) /
            2);
    _trackPadding = EdgeInsets.symmetric(
      horizontal: widget.sliderWidget.size / 2,
    );
    return RepaintBoundary(
      child: LayoutBuilder(builder: (context, constraints) {
        double $sliderSize = constraints.maxWidth - widget.sliderWidget.size;
        if (_maxDragSize == null) {
          _maxDragSize = $sliderSize;
        } else if ($sliderSize != _maxDragSize) {
          _maxDragSize = $sliderSize;
          _currentDragValue = sliderValue;
        }
        return Stack(
          clipBehavior: Clip.none,
          children: [
            buildTrack(),
            buildPrimaryTrack(),
            buildSlider(),
          ],
        );
      }),
    );
  }

  /// 构建 Slider 轨道
  Widget buildTrack() {
    return SizedBox(
      height: widget.sliderWidget.size,
      child: Center(
        child: Padding(
          padding: _trackPadding,
          child: GestureDetector(
            onHorizontalDragDown: (e) {
              _startDrag();
              _currentDragValue = e.localPosition.dx;
              modelValue = _calcSliderValue();
            },
            onHorizontalDragUpdate: !isDrag
                ? null
                : (e) {
                    _updateDrag(e);
                  },
            onHorizontalDragEnd: !isDrag
                ? null
                : (e) {
                    _endDrag(e);
                  },
            onHorizontalDragCancel: !isDrag
                ? null
                : () {
                    cancelDrag();
                  },
            child: ElHoverBuilder(
                cursor: SystemMouseCursors.click,
                builder: (context) {
                  return Container(
                    height: widget.thumbSize,
                    decoration: BoxDecoration(
                      color: context.elTheme.sliderStyle.inactiveColor,
                      borderRadius: _trackRadius,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  /// 构建 Slider 拖拽形成的轨道
  Widget buildPrimaryTrack() {
    return Positioned(
      child: IgnorePointer(
        child: SizedBox(
          height: widget.sliderWidget.size,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: _trackPadding,
              child: Container(
                width: sliderValue,
                height: widget.thumbSize,
                decoration: BoxDecoration(
                  color: context.elTheme.primary,
                  borderRadius: _trackRadius,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 构建 Slider 滑块按钮
  Widget buildSlider() {
    return Positioned(
      left: sliderValue,
      child: GestureDetector(
        onHorizontalDragDown: (e) {
          setState(() {
            _startDrag();
          });
        },
        onHorizontalDragUpdate: !isDrag
            ? null
            : (e) {
                _updateDrag(e);
              },
        onHorizontalDragEnd: !isDrag
            ? null
            : (e) {
                _endDrag(e);
              },
        onHorizontalDragCancel: !isDrag
            ? null
            : () {
                cancelDrag();
              },
        child: ElHoverBuilder(
            cursor: widget.cursor ?? ElCursorUtil.grab,
            builder: (context) {
              return _SlideInheritedWidget(
                ElSliderState(
                  isDrag: isDrag,
                ),
                child: widget.sliderWidget,
              );
            }),
      ),
    );
  }
}
