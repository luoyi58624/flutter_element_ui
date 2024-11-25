part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '轮廓环默认样式')
class ElRingThemeData {
  static const _defaultTheme = ElRingThemeData(
    show: false,
    offset: 1.5,
    width: 2.0,
  );
  static const theme = _defaultTheme;
  static const darkTheme = _defaultTheme;

  const ElRingThemeData({
    this.duration,
    this.curve,
    this.show,
    this.offset,
    this.width,
    this.radius,
    this.color,
  });

  /// 动画持续时间
  final Duration? duration;

  /// 动画曲线
  final Curve? curve;

  /// 是否显示轮廓环，默认 false
  final bool? show;

  /// 轮廓环与子组件的距离，默认 1.0
  final double? offset;

  /// 轮廓环的宽度，默认 1.5
  final double? width;

  /// 轮廓环的圆角值，Element UI 很多组件会通过 [setRingRadius] 方法自动设置轮廓环的圆角
  final BorderRadius? radius;

  /// 轮廓环的颜色
  final Color? color;
}
