import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_ui/src/services/toast.dart';

part '../../generates/styles/feedback/toast.g.dart';

@ElModel.copy()
class ElToastStyle {
  const ElToastStyle({
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
