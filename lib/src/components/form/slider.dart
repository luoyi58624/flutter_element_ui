import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

class ElSlider extends HookWidget {
  const ElSlider(
    this.modelValue, {
    super.key,
    this.trackSize = 4,
    this.thumbSize = 18,
  });

  final ValueNotifier<double> modelValue;

  /// 轨道尺寸
  final double trackSize;

  /// 滑块尺寸
  final double thumbSize;

  @override
  Widget build(BuildContext context) {
    final $activeColor = context.elTheme.sliderActiveColor;
    final $borderRadius = BorderRadius.circular(thumbSize / 2);
    return Stack(
      children: [
        SizedBox(
          height: thumbSize,
          child: Center(
            child: Container(
              height: trackSize,
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
                width: thumbSize,
                height: thumbSize,
                decoration: BoxDecoration(
                  color: $activeColor,
                  borderRadius: $borderRadius,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class ElSlider2 extends StatelessWidget {
  const ElSlider2({
    super.key,
    required this.value,
    required this.onChanged,
    this.trackSize = 4,
    this.thumbSize = 18,
  });

  final double value;

  /// 轨道尺寸
  final double trackSize;

  /// 滑块尺寸
  final double thumbSize;

  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onHorizontalDragUpdate: (e) {
          i(e.delta.dx, 'xxx');
          onChanged(value + e.delta.dx);
        },
        child: CustomPaint(
          size: Size(double.infinity, thumbSize),
          painter: _ThumbPainter(trackSize),
          foregroundPainter: _SliderPainter(value),
          // child: Container(
          //   height: 8,
          //   color: Colors.red,
          // ),
        ),
      ),
    );
  }
}

class _ThumbPainter extends CustomPainter {
  final double trackSize;

  _ThumbPainter(this.trackSize);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey.shade300;
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        (size.height / 2 - trackSize / 2),
        size.width,
        trackSize,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool? hitTest(Offset position) {
    return false;
  }
}

class _SliderPainter extends CustomPainter {
  final double value;

  _SliderPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    i(value);
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green;
    canvas.drawCircle(Offset(value, size.height / 2), size.height / 2, paint);
  }

  @override
  bool shouldRepaint(covariant _SliderPainter oldDelegate) {
    return oldDelegate.value != value;
  }

  @override
  bool? hitTest(Offset position) {
    return true;
  }
}
