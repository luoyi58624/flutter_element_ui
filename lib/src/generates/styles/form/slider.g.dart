// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/form/slider.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElSliderStyleExtension on ElSliderStyle {
  ElSliderStyle copyWith({
    double? sliderSize,
    double? thumbSize,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return ElSliderStyle(
      sliderSize: sliderSize ?? this.sliderSize,
      thumbSize: thumbSize ?? this.thumbSize,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
  }

  ElSliderStyle merge([ElSliderStyle? other]) {
    if (other == null) return this;
    return copyWith(
      sliderSize: other.sliderSize,
      thumbSize: other.thumbSize,
      activeColor: other.activeColor,
      inactiveColor: other.inactiveColor,
    );
  }
}
