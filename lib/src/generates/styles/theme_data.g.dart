// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/theme_data.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElThemeDataExtension on ElThemeData {
  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    Color? bgColor,
    Color? borderColor,
    Color? textColor,
    Color? iconColor,
    ElButtonStyle? buttonStyle,
    ElLinkStyle? linkStyle,
    ElInputStyle? inputStyle,
    ElCollapseStyle? collapseStyle,
    ElCardStyle? cardStyle,
    ElModalStyle? modalStyle,
    ElMessageStyle? messageStyle,
    ElToastStyle? toastStyle,
    ElTooltipStyle? tooltipStyle,
    ElSliderStyle? sliderStyle,
    ElHeaderStyle? headerStyle,
    ElAsideStyle? asideStyle,
    ElNavigationMenuStyle? navigationMenuStyle,
  }) {
    return ElThemeData(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      bgColor: bgColor ?? this.bgColor,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      buttonStyle: this.buttonStyle.merge(buttonStyle),
      linkStyle: this.linkStyle.merge(linkStyle),
      inputStyle: this.inputStyle.merge(inputStyle),
      collapseStyle: this.collapseStyle.merge(collapseStyle),
      cardStyle: this.cardStyle.merge(cardStyle),
      modalStyle: this.modalStyle.merge(modalStyle),
      messageStyle: this.messageStyle.merge(messageStyle),
      toastStyle: this.toastStyle.merge(toastStyle),
      tooltipStyle: this.tooltipStyle.merge(tooltipStyle),
      sliderStyle: this.sliderStyle.merge(sliderStyle),
      headerStyle: this.headerStyle.merge(headerStyle),
      asideStyle: this.asideStyle.merge(asideStyle),
      navigationMenuStyle: this.navigationMenuStyle.merge(navigationMenuStyle),
    );
  }

  ElThemeData merge([ElThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      primary: other.primary,
      success: other.success,
      info: other.info,
      warning: other.warning,
      error: other.error,
      bgColor: other.bgColor,
      borderColor: other.borderColor,
      textColor: other.textColor,
      iconColor: other.iconColor,
      buttonStyle: buttonStyle?.merge(other.buttonStyle),
      linkStyle: linkStyle?.merge(other.linkStyle),
      inputStyle: inputStyle?.merge(other.inputStyle),
      collapseStyle: collapseStyle?.merge(other.collapseStyle),
      cardStyle: cardStyle?.merge(other.cardStyle),
      modalStyle: modalStyle?.merge(other.modalStyle),
      messageStyle: messageStyle?.merge(other.messageStyle),
      toastStyle: toastStyle?.merge(other.toastStyle),
      tooltipStyle: tooltipStyle?.merge(other.tooltipStyle),
      sliderStyle: sliderStyle?.merge(other.sliderStyle),
      headerStyle: headerStyle?.merge(other.headerStyle),
      asideStyle: asideStyle?.merge(other.asideStyle),
      navigationMenuStyle:
          navigationMenuStyle?.merge(other.navigationMenuStyle),
    );
  }
}
