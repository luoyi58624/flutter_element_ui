import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/feedback/message.g.dart';

@ElModel.copy()
class ElMessageStyle {
  const ElMessageStyle({
    this.offset = 20,
    this.messageDuration = 3000,
    this.animationDuration = 300,
    this.showClose = false,
    this.grouping = false,
  });

  /// 第一条消息距离顶部窗口的距离，默认20
  final double offset;

  /// 消息持续时间，默认 3000 毫秒
  final int messageDuration;

  /// 动画持续时间，默认 300 毫秒
  final int animationDuration;

  /// 是否显示关闭按钮：默认false
  final bool showClose;

  /// 是否合并相同消息，默认false
  final bool grouping;
}