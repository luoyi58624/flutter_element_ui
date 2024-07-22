import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/model.dart';

import 'basic/button.dart';
import 'basic/input.dart';

part '../generates/styles/config.g.dart';

/// 全局配置，定义了所有组件的默认配置信息
@ElModel(copyWith: true)
class ElConfigData {
  static ElConfigData data = ElConfigData();

  /// 常用控件的基本高度
  double baseHeight;

  /// 全局默认图标大小
  double iconSize;

  /// 全局基础控件圆角值: button、input
  BorderRadius radius;

  /// 全局卡片圆角值
  BorderRadius cardRadius;

  /// 背景颜色过渡持续时间(毫秒)
  int bgTransition;

  /// 折叠动画持续时间(毫秒)
  int collapseDuration;

  /// 全局文本样式
  TextStyle textStyle;

  /// 按钮全局样式
  ElButtonStyle buttonStyle;

  /// 输入框全局样式
  ElInputStyle inputStyle;

  ElConfigData({
    this.baseHeight = 36,
    this.iconSize = 18,
    this.radius = const BorderRadius.all(Radius.circular(4)),
    this.cardRadius = const BorderRadius.all(Radius.circular(6)),
    this.bgTransition = 100,
    this.collapseDuration = 250,
    this.textStyle = const TextStyle(fontSize: 15),
    this.buttonStyle = const ElButtonStyle(),
    this.inputStyle = const ElInputStyle(),
  }) : assert(baseHeight >= 24);
}
