part of 'index.dart';

const _duration = Duration(milliseconds: 250);
const _curve = Curves.easeInOut;

class _ElSliderState extends ElModelValueState<ElSlider, double>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: _duration,
  );
  late CurvedAnimation _curvedAnimation;

  /// 允许拖拽的最大尺寸
  double? _maxDragSize;

  /// 当前拖拽的物理像素
  late double _currentDragValue;

  /// 轨道圆角
  late BorderRadiusGeometry _trackRadius;

  /// 轨道内边距
  late EdgeInsetsGeometry _trackPadding;

  /// 是否开始拖拽
  bool isDrag = false;

  /// 当前 [modelValue] 在最大值、最小值之间的比例
  double get _valueRatio =>
      max((modelValue - widget.min), 0) / (widget.max - widget.min);

  /// 显示在视图上的滑块偏移值
  double get _sliderValue {
    assert(_maxDragSize != null, 'ElSlider _maxDragSize 未初始化');
    return _maxDragSize! * _valueRatio;
  }

  @override
  void initState() {
    super.initState();
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: _curve,
    );
  }

  @override
  void didUpdateWidget(covariant ElSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.max != oldWidget.max || widget.min != oldWidget.min) {
      _currentDragValue = _sliderValue;
      if (widget.max < modelValue) {
        ElUtils.nextTick(() {
          modelValue = widget.max;
          _currentDragValue = _sliderValue;
        });
      }
      if (widget.min > modelValue) {
        ElUtils.nextTick(() {
          modelValue = widget.min;
          _currentDragValue = _sliderValue;
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// 更新拖拽事件
  void _updateDrag(DragUpdateDetails e) {
    _currentDragValue += e.delta.dx;
    _updateSliderValue();
  }

  /// 结束拖拽事件
  void _endDrag(DragEndDetails e) {
    setState(() {
      isDrag = false;
      if (_currentDragValue < 0) {
        _currentDragValue = 0;
      } else if (_currentDragValue > _maxDragSize!) {
        _currentDragValue = _maxDragSize!;
      }
    });
  }

  /// 取消拖拽事件
  void cancelDrag() {
    setState(() {
      isDrag = false;
    });
  }

  /// 更新滑块值，通知视图刷新
  void _updateSliderValue() {
    late double value;
    if (_currentDragValue <= 0) {
      value = widget.min;
    } else if (_currentDragValue >= _maxDragSize!) {
      value = widget.max;
    } else {
      value = (_currentDragValue / _maxDragSize!) * (widget.max - widget.min);
      value += widget.min;
    }
    modelValue = value;
  }

  @override
  Widget builder(BuildContext context) {
    _trackRadius = widget.disabledThumbRadius
        ? BorderRadius.zero
        : BorderRadius.circular(max(
                max(widget.thumbSize, widget.hoverThumbSize),
                widget.activeThumbSize) /
            2);
    _trackPadding = EdgeInsets.symmetric(
      horizontal: widget.thumbWidget.size / 2,
    );
    if (isDrag) {
      el.cursor.add(widget.cursor ?? ElCursorUtil.grabbing);
    } else {
      el.cursor.remove();
    }
    return RepaintBoundary(
      child: LayoutBuilder(builder: (context, constraints) {
        double $sliderSize = constraints.maxWidth - widget.thumbWidget.size;
        if (_maxDragSize == null || _maxDragSize != $sliderSize) {
          _maxDragSize = $sliderSize;
          _currentDragValue = _sliderValue;
        }
        return Stack(
          clipBehavior: Clip.none,
          children: [
            buildTrack(),
            buildPrimaryTrack(),
            buildThumb(),
          ],
        );
      }),
    );
  }

  /// 构建 Slider 轨道
  Widget buildTrack() {
    return SizedBox(
      height: widget.thumbWidget.size,
      child: Center(
        child: Padding(
          padding: _trackPadding,
          child: GestureDetector(
            onHorizontalDragDown: (e) {
              isDrag = true;
              _currentDragValue = e.localPosition.dx;
              _updateSliderValue();
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
          height: widget.thumbWidget.size,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: _trackPadding,
              child: Container(
                width: _sliderValue,
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
  Widget buildThumb() {
    return Positioned(
      left: _sliderValue,
      child: GestureDetector(
        onHorizontalDragDown: (e) {
          setState(() {
            isDrag = true;
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
                child: widget.thumbWidget,
              );
            }),
      ),
    );
  }
}
