import 'package:flutter_element_ui/src/global.dart';

part '../../generates/themes/services/message.g.dart';

@ElModel.copy()
class ElMessageThemeData {
  const ElMessageThemeData({
    this.offset = 20,
    this.closeDuration = 3000,
    this.animationDuration = 300,
    this.showClose = true,
    this.grouping = false,
    this.builder,
  });

  /// 第一条消息距离顶部窗口的距离，默认20
  final double offset;

  /// 自动关闭时间，默认 3000 毫秒
  final int closeDuration;

  /// 动画持续时间，默认 300 毫秒
  final int animationDuration;

  /// 是否显示关闭按钮：默认false
  final bool showClose;

  /// 是否合并相同消息，默认false
  final bool grouping;

  /// 自定义全局 message 小部件
  final ElMessageBuilder? builder;
}
