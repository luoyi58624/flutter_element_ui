// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/link.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElLinkStyleExtension on ElLinkStyle {
  ElLinkStyle copyWith({
    MouseCursor? cursor,
    Color? color,
    Color? activeColor,
    ElLinkDecoration? decoration,
    bool? enabledPreview,
    bool? enableFeedback,
  }) {
    return ElLinkStyle(
      cursor: cursor ?? this.cursor,
      color: color ?? this.color,
      activeColor: activeColor ?? this.activeColor,
      decoration: decoration ?? this.decoration,
      enabledPreview: enabledPreview ?? this.enabledPreview,
      enableFeedback: enableFeedback ?? this.enableFeedback,
    );
  }

  ElLinkStyle merge([ElLinkStyle? other]) {
    if (other == null) return this;
    return copyWith(
      cursor: other.cursor,
      color: other.color,
      activeColor: other.activeColor,
      decoration: other.decoration,
      enabledPreview: other.enabledPreview,
      enableFeedback: other.enableFeedback,
    );
  }
}
