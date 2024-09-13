// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/color_data.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElColorDataExtension on ElColorData {
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
