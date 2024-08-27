import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_element_ui/global.dart';

class ElSlider extends HookWidget {
  const ElSlider(
    this.modelValue, {
    super.key,
    this.sliderSize = 18,
    this.thumbSize = 4,
  });

  final ValueNotifier<double> modelValue;

  /// 整体滑块尺寸
  final double sliderSize;

  /// 滑块轨道尺寸
  final double thumbSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: sliderSize,
          child: Center(
            child: Container(
              height: thumbSize,
              color: context.elTheme.sliderInactiveColor,
            ),
          ),
        ),
        ObsBuilder(builder: (context) {
          return Positioned(
            left: max(modelValue.value, 0),
            child: GestureDetector(
              onHorizontalDragUpdate: (e) {
                modelValue.value += e.delta.dx;
              },
              onHorizontalDragEnd: (e) {
                modelValue.value = max(modelValue.value, 0);
              },
              child: Container(
                width: sliderSize,
                height: sliderSize,
                decoration: BoxDecoration(
                  color: context.elTheme.sliderActiveColor,
                  borderRadius: BorderRadius.circular(sliderSize / 2),
                ),
              ),
            ),
          );
        }),
      ],
    );
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
