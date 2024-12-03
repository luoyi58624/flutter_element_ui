part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '图标默认样式', generateAnimatedThemeWidget: true)
class ElIconThemeData {
  static const theme = ElIconThemeData(
    color: Color.fromRGBO(96, 98, 102, 1.0),
    size: 18,
  );
  static const darkTheme = ElIconThemeData(
    color: Color(0xfff6f6f6),
    size: 18,
  );

  const ElIconThemeData({
    this.icon,
    this.size,
    this.color,
  });

  /// 默认的图标
  final dynamic icon;

  /// 图标尺寸，默认 18
  final double? size;

  /// 图标颜色
  final Color? color;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
