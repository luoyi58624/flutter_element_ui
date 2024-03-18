part of flutter_element_ui;

class ElConfigData {
  /// 默认的icon大小
  double iconSize;

  /// 组件默认圆角值
  double radius;

  /// 按钮默认高度
  double buttonHeight;

  /// 按钮水平间距
  double get buttonHorizontal => buttonHeight / 2;

  /// 按钮图标大小
  double get buttonIconSize => buttonHeight / 2;

  ElConfigData({
    this.iconSize = 20,
    this.radius = 4,
    this.buttonHeight = 32,
  });

  ElConfigData copyWith(ElConfigData? config) {
    iconSize = config?.iconSize ?? iconSize;
    radius = config?.radius ?? radius;
    buttonHeight = config?.buttonHeight ?? buttonHeight;
    return this;
  }
}
