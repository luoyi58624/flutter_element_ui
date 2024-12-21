part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '对话框默认样式', generateThemeWidget: false)
class ElDialogThemeData {
  static const theme = ElDialogThemeData();
  static const darkTheme = ElDialogThemeData();

  const ElDialogThemeData({
    this.animationDuration = const Duration(milliseconds: 300),
    this.alignment = Alignment.topCenter,
    this.offset = const Offset(0, 100),
  });

  /// 显示对话框动画持续时间，默认 300 毫秒
  final Duration animationDuration;

  /// 对话框默认显示位置，默认顶部居中
  final Alignment alignment;

  /// 对话框相对 [alignment] 的偏移值
  final Offset offset;


  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
