part of flutter_element_ui;

class ElConfigData {
  static ElConfigData config = ElConfigData();

  /// 默认的icon大小
  double iconSize;

  /// 按钮全局样式
  late ElButtonStyle buttonStyle;

  /// 输入框全局圆角值
  double inputRadius;

  /// 卡片全局圆角值
  double cardRadius;

  ElConfigData({
    this.iconSize = 20,
    ElButtonStyle? buttonStyle,
    this.cardRadius = 6,
    this.inputRadius = 6,
  }) {
    this.buttonStyle = ElButtonStyle.style.merge(buttonStyle);
  }

  ElConfigData copyWith({
    ElButtonStyle? buttonStyle,
    double? iconSize,
    double? cardRadius,
    double? inputRadius,
  }) {
    return ElConfigData(
      iconSize: iconSize ?? this.iconSize,
      buttonStyle: buttonStyle ?? this.buttonStyle,
      cardRadius: cardRadius ?? this.cardRadius,
      inputRadius: inputRadius ?? this.inputRadius,
    );
  }
}
