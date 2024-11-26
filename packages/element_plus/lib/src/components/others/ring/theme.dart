part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '轮廓环默认样式')
class ElRingThemeData {
  static const _defaultTheme = ElRingThemeData(
    offset: 2.0,
    width: 2.0,
  );
  static const theme = _defaultTheme;
  static const darkTheme = _defaultTheme;

  const ElRingThemeData({
    this.duration,
    this.curve,
    this.show,
    this.width,
    this.offset,
    this.radius,
    this.color,
  });

  /// 动画持续时间
  final Duration? duration;

  /// 动画曲线
  final Curve? curve;

  /// 是否显示轮廓环
  final bool? show;

  /// 轮廓环的宽度
  final double? width;

  /// 轮廓环与子组件的距离
  final double? offset;

  /// 轮廓环的圆角值，圆角值和目标小部件保持一致就行，ElRing 内部会自动计算出符合视觉的最终圆角
  final BorderRadius? radius;

  /// 轮廓环的颜色，默认主题色
  final Color? color;
}
