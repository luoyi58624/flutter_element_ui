import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/model.dart';

import 'basic/button.dart';
import 'basic/input.dart';
import 'feedback/message.dart';

part '../generates/styles/config.g.dart';

@ElModel(copyWith: true)
class ElConfigData {
  static ElConfigData data = ElConfigData();

  /// 基础控件的基本高度：按钮、输入框...
  double baseWidgetHeight;

  /// 全局默认图标大小
  double iconSize;

  /// 基础控件圆角值（小尺寸控件）: 按钮、输入框...
  BorderRadius radius;

  /// 全局卡片圆角值（大尺寸控件）：卡片、弹窗...
  BorderRadius cardRadius;

  /// 背景颜色过渡持续时间(毫秒)
  Duration bgDuration;

  /// 折叠动画持续时间(毫秒)
  Duration collapseDuration;

  /// 全局文本样式
  TextStyle textStyle;

  /// 按钮全局样式
  ElButtonStyle buttonStyle;

  /// 输入框全局样式
  ElInputStyle inputStyle;

  /// 消息提示全局样式
  ElMessageStyle messageStyle;

  /// Element UI 全局配置，定义了所有组件的默认配置信息
  ElConfigData({
    this.baseWidgetHeight = 36,
    this.iconSize = 18,
    this.radius = const BorderRadius.all(Radius.circular(4)),
    this.cardRadius = const BorderRadius.all(Radius.circular(6)),
    this.bgDuration = const Duration(milliseconds: 100),
    this.collapseDuration = const Duration(milliseconds: 250),
    this.textStyle = const TextStyle(),
    this.buttonStyle = const ElButtonStyle(),
    this.inputStyle = const ElInputStyle(),
    this.messageStyle = const ElMessageStyle(),
  }) : assert(baseWidgetHeight >= 24);
}
