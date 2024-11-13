part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '消息提示默认样式', generateThemeWidget: false)
class ElMessageThemeData {
  static const theme = ElMessageThemeData();
  static const darkTheme = ElMessageThemeData();

  const ElMessageThemeData({
    this.offset = 20,
    this.closeDuration = const Duration(milliseconds: 3000),
    this.animationDuration = const Duration(milliseconds: 300),
    this.showClose = true,
    this.grouping = false,
    this.builder,
  });

  /// 第一条消息距离顶部窗口的距离，默认20
  final double offset;

  /// 自动关闭时间，默认 3000 毫秒
  final Duration closeDuration;

  /// 动画持续时间，默认 300 毫秒
  final Duration animationDuration;

  /// 是否显示关闭按钮：默认false
  final bool showClose;

  /// 是否合并相同消息，默认false
  final bool grouping;

  /// 自定义全局 message 小部件
  final ElMessageBuilder? builder;
}
