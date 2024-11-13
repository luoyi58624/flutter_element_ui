part of 'index.dart';

@ElModel.copy()
class ElConfigData {
  /// Element UI 默认全局配置
  static const ElConfigData data = ElConfigData();

  /// 基础控件默认尺寸，例如：按钮、输入框...
  final double size;

  /// 基础控件默认圆角值
  final BorderRadius radius;

  /// 基础控件默认边框尺寸
  final double borderSize;

  const ElConfigData({
    this.size = 36,
    this.radius = const BorderRadius.all(Radius.circular(4)),
    this.borderSize = 1.0,
  }) : assert(size >= 24);
}
