// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/config.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ConfigDataExtension on ConfigData {
  /// 接收一组可选参数，返回新的对象
  ConfigData copyWith({
    double? baseHeight,
    BorderRadius? radius,
    Duration? themeDuration,
    Curve? themeCurve,
  }) {
    return ConfigData(
      baseHeight: baseHeight ?? this.baseHeight,
      radius: radius ?? this.radius,
      themeDuration: themeDuration ?? this.themeDuration,
      themeCurve: themeCurve ?? this.themeCurve,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ConfigData merge([ConfigData? other]) {
    if (other == null) return this;
    return copyWith(
      baseHeight: other.baseHeight,
      radius: other.radius,
      themeDuration: other.themeDuration,
      themeCurve: other.themeCurve,
    );
  }
}