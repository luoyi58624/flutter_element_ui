part of 'index.dart';

@ElModel.copy()
@ElThemeDataModel()
class ElCollapseThemeData {
  const ElCollapseThemeData({
    this.keepState = true,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeInOut,
  });

  /// 当子组件被折叠时是否保留状态，默认true
  final bool keepState;

  /// 折叠动画时间
  final Duration duration;

  /// 折叠动画曲线
  final Curve curve;
}
