// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lint_alpha, lint_beta

part of '../../styles/button.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButtonStyleExtension on ElButtonStyle {
  ElButtonStyle copyWith({
    double? height,
    bool? text,
    bool? plain,
    bool? round,
    bool? block,
    BorderRadiusGeometry? radius,
    EdgeInsetsGeometry? padding,
    bool? circle,
    bool? disabled,
  }) {
    return ElButtonStyle(
      height: height ?? this.height,
      text: text ?? this.text,
      plain: plain ?? this.plain,
      round: round ?? this.round,
      block: block ?? this.block,
      radius: radius ?? this.radius,
      padding: padding ?? this.padding,
      circle: circle ?? this.circle,
      disabled: disabled ?? this.disabled,
    );
  }

  ElButtonStyle merge([ElButtonStyle? style]) {
    if (style == null) return this;
    return copyWith(
      height: style.height,
      text: style.text,
      plain: style.plain,
      round: style.round,
      block: style.block,
      radius: style.radius,
      padding: style.padding,
      circle: style.circle,
      disabled: style.disabled,
    );
  }

  String _toString() {
    return 'ElButtonStyle{height: $height,text: $text,plain: $plain,round: $round,block: $block,radius: $radius,padding: $padding,circle: $circle,disabled: $disabled}';
  }
}
