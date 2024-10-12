// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/color.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElColorDataExtension on ElColorData {
  /// 接收一组可选参数，返回新的对象
  ElColorData copyWith({
    Color? bg,
    Color? icon,
    Color? text,
    Color? regularText,
    Color? secondaryText,
    Color? placeholderText,
    Color? border,
  }) {
    return ElColorData(
      bg: bg ?? this.bg,
      icon: icon ?? this.icon,
      text: text ?? this.text,
      regularText: regularText ?? this.regularText,
      secondaryText: secondaryText ?? this.secondaryText,
      placeholderText: placeholderText ?? this.placeholderText,
      border: border ?? this.border,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElColorData merge([ElColorData? other]) {
    if (other == null) return this;
    return copyWith(
      bg: other.bg,
      icon: other.icon,
      text: other.text,
      regularText: other.regularText,
      secondaryText: other.secondaryText,
      placeholderText: other.placeholderText,
      border: other.border,
    );
  }
}
