import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_obs/flutter_obs.dart';

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
