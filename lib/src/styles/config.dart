part of flutter_element_ui;

class ElConfigData {
  static ElConfigData config = ElConfigData();

  /// 默认的icon大小
  double iconSize;

  /// 按钮默认高度
  double buttonHeight;

  /// 按钮全局圆角值
  double buttonRadius;

  /// 输入框全局圆角值
  double inputRadius;

  /// 卡片全局圆角值
  double cardRadius;

  /// 按钮水平间距
  double get buttonHorizontal => buttonHeight / 2;

  /// 按钮图标大小
  double get buttonIconSize => buttonHeight / 2;

  ElConfigData({
    this.iconSize = 20,
    this.buttonHeight = 36,
    this.buttonRadius = 4,
    this.cardRadius = 6,
    this.inputRadius = 6,
  });

  ElConfigData copyWith({
    String? fontFamily,
    double? iconSize,
    double? buttonHeight,
    double? buttonRadius,
    double? cardRadius,
    double? inputRadius,
  }) {
    return ElConfigData(
      iconSize: iconSize ?? this.iconSize,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      buttonRadius: buttonRadius ?? this.buttonRadius,
      cardRadius: cardRadius ?? this.cardRadius,
      inputRadius: inputRadius ?? this.inputRadius,
    );
  }
}
