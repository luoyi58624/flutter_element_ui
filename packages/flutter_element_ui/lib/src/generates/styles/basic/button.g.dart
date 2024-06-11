// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/button.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButtonStyleExtension on ElButtonStyle {
  ElButtonStyle copyWith({
    double? height,
    Color? bgColor,
    Color? color,
    ElThemeType? type,
    bool? text,
    bool? plain,
    bool? round,
    bool? block,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
    ElIcon? leftIcon,
    ElIcon? rightIcon,
    bool? circle,
    bool? disabled,
    bool? loading,
  }) {
    return ElButtonStyle(
      height: height ?? this.height,
      bgColor: bgColor ?? this.bgColor,
      color: color ?? this.color,
      type: type ?? this.type,
      text: text ?? this.text,
      plain: plain ?? this.plain,
      round: round ?? this.round,
      block: block ?? this.block,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      leftIcon: leftIcon ?? this.leftIcon,
      rightIcon: rightIcon ?? this.rightIcon,
      circle: circle ?? this.circle,
      disabled: disabled ?? this.disabled,
      loading: loading ?? this.loading,
    );
  }

  ElButtonStyle merge([ElButtonStyle? other]) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      bgColor: other.bgColor,
      color: other.color,
      type: other.type,
      text: other.text,
      plain: other.plain,
      round: other.round,
      block: other.block,
      borderRadius: other.borderRadius,
      padding: other.padding,
      leftIcon: other.leftIcon,
      rightIcon: other.rightIcon,
      circle: other.circle,
      disabled: other.disabled,
      loading: other.loading,
    );
  }
}
