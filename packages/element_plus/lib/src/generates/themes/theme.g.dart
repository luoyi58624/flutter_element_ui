// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElThemeDataExtension on ElThemeData {
  /// 接收一组可选参数，返回新的对象
  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    ElColorData? colors,
    ElButtonThemeData? buttonTheme,
    ElLinkThemeData? linkTheme,
    ElInputThemeData? inputTheme,
    ElCollapseThemeData? collapseTheme,
    ElProgressThemeData? progressTheme,
    ElCardThemeData? cardTheme,
    ElModalThemeData? modalTheme,
    ElMessageThemeData? messageTheme,
    ElToastThemeData? toastTheme,
    ElTooltipThemeData? tooltipTheme,
    ElSliderThemeData? sliderTheme,
    ElHeaderThemeData? headerTheme,
    ElAsideThemeData? asideTheme,
    ElNavMenuThemeData? navigationMenuTheme,
    ElTabsThemeData? tabsTheme,
    ElTabThemeData? tabTheme,
    ElCodePreviewThemeData? codePreviewTheme,
  }) {
    return ElThemeData(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      colors: this.colors.merge(colors),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      navigationMenuTheme: this.navigationMenuTheme.merge(navigationMenuTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElThemeData merge([ElThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      primary: other.primary,
      success: other.success,
      info: other.info,
      warning: other.warning,
      error: other.error,
      colors: other.colors,
      buttonTheme: other.buttonTheme,
      linkTheme: other.linkTheme,
      inputTheme: other.inputTheme,
      collapseTheme: other.collapseTheme,
      progressTheme: other.progressTheme,
      cardTheme: other.cardTheme,
      modalTheme: other.modalTheme,
      messageTheme: other.messageTheme,
      toastTheme: other.toastTheme,
      tooltipTheme: other.tooltipTheme,
      sliderTheme: other.sliderTheme,
      headerTheme: other.headerTheme,
      asideTheme: other.asideTheme,
      navigationMenuTheme: other.navigationMenuTheme,
      tabsTheme: other.tabsTheme,
      tabTheme: other.tabTheme,
      codePreviewTheme: other.codePreviewTheme,
    );
  }
}
