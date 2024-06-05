part of 'button.dart';

extension ElButtonStyleExtension on ElButtonStyle {
  ElButtonStyle copyWith({
    double? height,
    ElThemeType? type,
    bool? text,
    bool? plain,
    bool? round,
    bool? block,
    BorderRadiusGeometry? radius,
    EdgeInsetsGeometry? padding,
    ElIcon? rightIcon,
    bool? circle,
    bool? disabled,
  }) {
    return ElButtonStyle(
      height: height ?? this.height,
      type: type ?? this.type,
      text: text ?? this.text,
      plain: plain ?? this.plain,
      round: round ?? this.round,
      block: block ?? this.block,
      radius: radius ?? this.radius,
      padding: padding ?? this.padding,
      rightIcon: rightIcon ?? this.rightIcon,
      circle: circle ?? this.circle,
      disabled: disabled ?? this.disabled,
    );
  }

  ElButtonStyle merge([ElButtonStyle? style]) {
    if (style == null) return this;
    return copyWith(
      height: style.height,
      type: style.type,
      text: style.text,
      plain: style.plain,
      round: style.round,
      block: style.block,
      radius: style.radius,
      padding: style.padding,
      rightIcon: style.rightIcon,
      circle: style.circle,
      disabled: style.disabled,
    );
  }
}
