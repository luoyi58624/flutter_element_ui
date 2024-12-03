part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: 'ElTree 主题数据')
class ElTreeThemeData {
  static const theme = ElTreeThemeData();
  static const darkTheme = ElTreeThemeData();

  const ElTreeThemeData({
    this.itemHeight = 36,
    this.iconSize = 18,
    this.parentGap = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
  });

  /// 高度
  final double itemHeight;

  /// 图标大小
  final double iconSize;

  /// 上一级间距
  final double parentGap;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 边框圆角
  final BorderRadius borderRadius;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
