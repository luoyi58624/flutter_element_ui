// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/other/code_preview.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCodePreviewStyleExtension on ElCodePreviewStyle {
  ElCodePreviewStyle copyWith({
    Color? color,
    Color? bgColor,
    bool? enableSection,
  }) {
    return ElCodePreviewStyle(
      color: color ?? this.color,
      bgColor: bgColor ?? this.bgColor,
      enableSection: enableSection ?? this.enableSection,
    );
  }

  ElCodePreviewStyle merge([ElCodePreviewStyle? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      bgColor: other.bgColor,
      enableSection: other.enableSection,
    );
  }
}
