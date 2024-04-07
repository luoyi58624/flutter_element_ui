part of flutter_element_ui;

/// Element 主题混入
mixin ElThemeMixin<T extends StatefulWidget, D> on State<T> {
  /// 暗色主题文字颜色
  Color get $textWhiteColor => ElAppData.of(context).darkTheme.textColor;

  /// 亮色主题文字颜色
  Color get $textBlackColor => ElAppData.of(context).theme.textColor;

  Color get $textColor => ElAppData.of(context).currentTheme.textColor;

  Color get $bgColor => ElAppData.of(context).currentTheme.bgColor;

  Color get $headerColor => ElAppData.of(context).currentTheme.headerColor;

  Color get $primaryColor => ElAppData.of(context).currentTheme.primary;

  Color get $successColor => ElAppData.of(context).currentTheme.success;

  Color get $infoColor => ElAppData.of(context).currentTheme.info;

  Color get $warningColor => ElAppData.of(context).currentTheme.warning;

  Color get $errorColor => ElAppData.of(context).currentTheme.error;

  Color get $defaultBorderColor => ElAppData.of(context).currentTheme.defaultBorderColor;

  double get $radius => ElAppData.of(context).config.radius;

  double get $buttonHeight => ElAppData.of(context).config.buttonHeight;

  double get $buttonHorizontal => ElAppData.of(context).config.buttonHorizontal;

  double get $buttonIconSize => ElAppData.of(context).config.buttonIconSize;

  Color get $menuActiveColor => ElAppData.of(context).currentTheme.menuActiveColor;
}
