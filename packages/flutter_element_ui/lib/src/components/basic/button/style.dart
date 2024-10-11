part of 'index.dart';

@ElModel.copy()
@ElThemeDataModel()
class ElButtonThemeData {
  const ElButtonThemeData({
    this.height,
    this.borderRadius,
    this.padding,
  });

  /// 按钮高度，默认全局 baseHeight
  final double? height;

  /// 按钮圆角，默认：radius
  final BorderRadius? borderRadius;

  /// 按钮内边距，默认为高度的一半
  final EdgeInsetsGeometry? padding;
}
