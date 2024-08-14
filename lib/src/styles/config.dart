import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/model.dart';

import 'basic/button.dart';
import 'basic/input.dart';
import 'feedback/message.dart';
import 'feedback/toast.dart';

part '../generates/styles/config.g.dart';

@ElModel(copyWith: true)
class ElConfigData {
  static ElConfigData data = ElConfigData();

  /// 全局默认图标大小
  double iconSize;

  /// 基础控件圆角值（小尺寸控件）: 按钮、输入框...
  BorderRadius radius;

  /// 全局卡片圆角值（大尺寸控件）：卡片、弹窗...
  BorderRadius cardRadius;

  /// 全局通用的过渡动画持续时间(毫秒)
  Duration globalDuration;

  /// 颜色过渡持续时间(毫秒)
  Duration colorDuration;

  /// 全局文本样式
  TextStyle textStyle;

  /// 按钮全局样式
  ElButtonStyle buttonStyle;

  /// 输入框全局样式
  ElInputStyle inputStyle;

  /// 消息提示全局样式
  ElMessageStyle messageStyle;

  /// 轻提示全局样式
  ElToastStyle toastStyle;

  /// Element UI 全局配置，定义了所有组件的默认配置信息
  ElConfigData({
    this.iconSize = 18,
    this.radius = const BorderRadius.all(Radius.circular(4)),
    this.cardRadius = const BorderRadius.all(Radius.circular(6)),
    this.globalDuration = const Duration(milliseconds: 250),
    this.colorDuration = const Duration(milliseconds: 100),
    this.textStyle = const TextStyle(),
    this.buttonStyle = const ElButtonStyle(),
    this.inputStyle = const ElInputStyle(),
    this.messageStyle = const ElMessageStyle(),
    this.toastStyle = const ElToastStyle(),
  });
}
