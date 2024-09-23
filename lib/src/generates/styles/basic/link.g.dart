// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/link.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElLinkStyleExtension on ElLinkStyle {
  ElLinkStyle copyWith({
    Color? color,
    Color? activeColor,
    ElLinkDecoration? decoration,
    bool? allowDrag,
  }) {
    return ElLinkStyle(
      color: color ?? this.color,
      activeColor: activeColor ?? this.activeColor,
      decoration: decoration ?? this.decoration,
      allowDrag: allowDrag ?? this.allowDrag,
    );
  }

  ElLinkStyle merge([ElLinkStyle? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      activeColor: other.activeColor,
      decoration: other.decoration,
      allowDrag: other.allowDrag,
    );
  }
}
