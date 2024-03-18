part of flutter_element_ui;

class ElConfigData {
  /// 默认的icon大小
  double iconSize;

  /// 组件全局圆角值
  double radius;

  ElConfigData({
    this.iconSize = 18,
    this.radius = 4,
  });

  ElConfigData copyWith(ElConfigData? config) {
    iconSize = config?.iconSize ?? iconSize;
    radius = config?.radius ?? radius;
    return this;
  }
}
