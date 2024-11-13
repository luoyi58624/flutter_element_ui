part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '轻提示默认样式', generateThemeWidget: false)
class ElToastThemeData {
  static const theme = ElToastThemeData();
  static const darkTheme = ElToastThemeData();

  const ElToastThemeData({
    this.closeDuration = 3000,
    this.enableFeedback = true,
    this.builder,
  });

  /// 自动关闭时间，默认 3000 毫秒
  final int closeDuration;

  /// 是否开启震动反馈
  final bool enableFeedback;

  /// 自定义全局 message 小部件
  final ElToastBuilder? builder;
}
