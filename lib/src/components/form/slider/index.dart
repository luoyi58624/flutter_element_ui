import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'package:flutter_element_ui/src/utils/cursor.dart';

import '../../../widgets/model_value.dart';

part 'state.dart';

part 'thumbs/default_thumb.dart';

part 'thumbs/progress_thumb.dart';

class ElSlider extends ElModelValue<double> {
  const ElSlider(
    super.modelValue, {
    super.key,
    super.onChanged,
    this.sliderWidget = const ElDefaultSlider(),
    this.min = 0.0,
    this.max = 100.0,
  })  : assert(min >= 0.0, 'ElSlider 最小值必须大于等于 0'),
        assert(max > min, 'ElSlider 最大值必须大于最小值');

  /// Slider 滑块小部件，你可以继承 [ElBaseSlider] 实现自定义滑块按钮
  final ElBaseSlider sliderWidget;

  /// 滑块最小值，默认 0
  final double min;

  /// 滑块最小值，默认 100
  final double max;

  @override
  State<ElSlider> createState() => _ElSliderState();
}

abstract class ElBaseSlider extends StatefulWidget {
  /// Element UI 滑块按钮抽象类，继承此类的小部件必须放置于 [ElSlider] 中
  const ElBaseSlider({
    super.key,
    this.thumbSize = 20,
    this.sliderSize,
    this.trackSize = 6,
    this.hoverTractSize = 6,
    this.activeTractSize = 6,
    this.tractRadius = 3,
    this.cursor,
    this.eventRange = ElSliderEventRange.track,
  })  : assert(sliderSize == null || sliderSize >= thumbSize),
        assert(thumbSize >= trackSize &&
            thumbSize >= hoverTractSize &&
            thumbSize >= activeTractSize);

  /// 滑块按钮尺寸
  final double thumbSize;

  /// 滑块整体尺寸，默认等于 [thumbSize] 滑块按钮尺寸
  final double? sliderSize;

  /// 轨道尺寸
  final double trackSize;

  /// 悬停时轨道尺寸
  final double hoverTractSize;

  /// 开始拖拽激活时轨道尺寸
  final double activeTractSize;

  /// 轨道圆角
  final double tractRadius;

  /// 自定义光标样式，默认为抓握样式
  final MouseCursor? cursor;

  /// 滑块触发事件范围，由于手指精确范围太过狭小，移动端强制 [ElSliderEventRange.slider]
  final ElSliderEventRange eventRange;

  /// 通过上下文访问 ElSlider 注入的状态数据
  ElSliderState of(BuildContext context) =>
      _SlideInheritedWidget.of(context).state;
}

/// ElSlider 事件触发范围
enum ElSliderEventRange {
  /// 交互范围只在滑块按钮上
  thumb,

  /// 交互范围在滑块按钮上、以及轨道上（默认）
  track,

  /// 交互范围在整个 slider 上
  slider,
}

class ElSliderState {
  /// 是否开始拖拽
  final bool isDrag;

  /// 鼠标是否悬停在滑块上
  final bool isHover;

  ElSliderState({
    required this.isDrag,
    required this.isHover,
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
    assert(result != null,
        '无法获取 ElSliderState 数据，你可能在单独使用滑块小部件，请将它放置在 ElSlider 中');
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
