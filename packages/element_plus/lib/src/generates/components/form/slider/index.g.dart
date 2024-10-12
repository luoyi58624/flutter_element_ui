// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/form/slider/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElSliderThemeDataExtension on ElSliderThemeData {
  /// 接收一组可选参数，返回新的对象
  ElSliderThemeData copyWith({
    double? sliderSize,
    double? thumbSize,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return ElSliderThemeData(
      sliderSize: sliderSize ?? this.sliderSize,
      thumbSize: thumbSize ?? this.thumbSize,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElSliderThemeData merge([ElSliderThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      sliderSize: other.sliderSize,
      thumbSize: other.thumbSize,
      activeColor: other.activeColor,
      inactiveColor: other.inactiveColor,
    );
  }
}
