import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_element_ui/src/extensions/event.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'package:flutter_element_ui/src/utils/cursor.dart';

import '../../../widgets/model_value.dart';

part 'state.dart';

part 'slider_widget.dart';

class ElSlider extends ElModelValue<double> {
  const ElSlider(
    super.modelValue, {
    super.key,
    super.onChanged,
    this.thumbWidget = const ElDefaultThumb(),
    this.min = 0.0,
    this.max = 100.0,
    this.sliderSize = 8,
    this.thumbSize = 6,
    this.hoverThumbSize = 6,
    this.activeThumbSize = 6,
    this.disabledThumbRadius = false,
    this.cursor,
  })  : assert(min >= 0.0, 'ElSlider 最小值必须大于等于 0'),
        assert(max > min, 'ElSlider 最大值必须大于最小值');

  /// Slider 滑块小部件，你可以继承 [ElBaseSlider] 实现自定义 Slider 样式
  final ElBaseThumb thumbWidget;

  /// 滑块最小值，默认 0
  final double min;

  /// 滑块最小值，默认 100
  final double max;

  /// 滑块尺寸
  final double sliderSize;

  /// 轨道尺寸
  final double thumbSize;

  /// 悬停时轨道尺寸
  final double hoverThumbSize;

  /// 开始拖拽激活时轨道尺寸
  final double activeThumbSize;

  /// 是否禁用轨道圆角，默认 false
  final bool disabledThumbRadius;

  /// 自定义光标样式
  final MouseCursor? cursor;

  @override
  State<ElSlider> createState() => _ElSliderState();
}

class ElSliderState {
  /// 是否开始拖拽
  final bool isDrag;

  ElSliderState({
    required this.isDrag,
  });
}

class _SlideInheritedWidget extends InheritedWidget {
  const _SlideInheritedWidget(
    this.state, {
    required super.child,
  });

  final ElSliderState state;

  static _SlideInheritedWidget of(BuildContext context) {
    final _SlideInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_SlideInheritedWidget>();
    assert(result != null, '无法获取 ElSliderState 数据，滑块小部件只能放置在 ElSlider 中');
    return result!;
  }

  @override
  bool updateShouldNotify(_SlideInheritedWidget oldWidget) {
    return true;
  }
}

class ElSlider2 extends LeafRenderObjectWidget {
  const ElSlider2({
    super.key,
    required this.value,
    required this.onChanged,
    this.sliderSize = 18,
    this.thumbSize = 4,
  });

  final double value;

  /// 整体滑块尺寸
  final double sliderSize;

  /// 滑块轨道尺寸
  final double thumbSize;

  final ValueChanged<double>? onChanged;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _SliderRender(
      value: value,
      sliderSize: sliderSize,
      thumbSize: thumbSize,
      onChanged: onChanged,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _SliderRender renderObject) {
    if (value != renderObject.value) {
      renderObject
        ..value = value
        ..sliderSize = sliderSize;
    }
  }
}

class _SliderRender extends RenderBox {
  _SliderRender({
    required this.value,
    required this.sliderSize,
    required this.thumbSize,
    this.onChanged,
  });

  double value;
  double sliderSize;
  double thumbSize;
  ValueChanged<double>? onChanged;

  late final HorizontalDragGestureRecognizer _drag =
      HorizontalDragGestureRecognizer()
        ..onUpdate = (e) {
          if (onChanged != null) {
            onChanged!(value + e.delta.dx);
            markNeedsPaint();
          }
        };

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, sliderSize);
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    // assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag.addPointer(event);
      // i(event);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final rect = offset & size;
    paintThumb(context, rect);
    paintSlider(context, rect);
  }

  /// 绘制滑块轨道
  void paintThumb(PaintingContext context, Rect rect) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey.shade300;
    context.canvas.drawRect(
      Rect.fromLTWH(
        0,
        (size.height / 2 - thumbSize / 2),
        size.width,
        thumbSize,
      ),
      paint,
    );
  }

  /// 绘制滑块拖拽控件
  void paintSlider(PaintingContext context, Rect rect) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;
    context.canvas.drawCircle(
      Offset(value, size.height / 2),
      size.height / 2,
      paint,
    );
  }
}
