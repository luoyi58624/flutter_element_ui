// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/feedback/tooltip/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTooltipThemeDataExtension on ElTooltipThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTooltipThemeData copyWith({
    Color? color,
    bool? enableFeedback,
  }) {
    return ElTooltipThemeData(
      color: color ?? this.color,
      enableFeedback: enableFeedback ?? this.enableFeedback,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTooltipThemeData merge([ElTooltipThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      enableFeedback: other.enableFeedback,
    );
  }
}
