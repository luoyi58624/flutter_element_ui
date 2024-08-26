import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import 'basic/button.dart';
import 'basic/input.dart';
import 'basic/link.dart';
import 'feedback/message.dart';
import 'feedback/toast.dart';

part '../generates/styles/config.g.dart';

@ElModel.copy()
class ElConfigData {
  /// 默认全局配置数据
  static const ElConfigData data = ElConfigData();

  /// 头部布局高度
  final double headerHeight;

  /// 通用控件高度
  final double baseHeight;

  /// 全局默认图标大小
  final double iconSize;

  /// 基础控件圆角值（小尺寸控件）: 按钮、输入框...
  final BorderRadius radius;

  /// 全局卡片圆角值（大尺寸控件）：卡片、弹窗...
  final BorderRadius cardRadius;

  /// 全局触觉回馈，默认false
  final bool enableFeedback;

  /// 全局通用的过渡动画持续时间
  final Duration globalDuration;

  /// 主题颜色过渡持续时间，建议和 MaterialApp 进行同步，防止切换暗黑模式出现不一致问题
  final Duration themeDuration;

  /// 主题动画过渡曲线，建议和 MaterialApp 进行同步
  final Curve themeCurve;

  /// 全局文本样式，它只作用于 [ElText] 小部件
  final TextStyle textStyle;

  /// 按钮全局样式
  final ElButtonStyle buttonStyle;

  /// 超链接全局样式
  final ElLinkStyle linkStyle;

  /// 输入框全局样式
  final ElInputStyle inputStyle;

  /// 消息提示全局样式
  final ElMessageStyle messageStyle;

  /// 轻提示全局样式
  final ElToastStyle toastStyle;

  /// Element UI 全局配置，定义了所有组件的默认配置信息
  const ElConfigData({
    this.headerHeight = 56,
    this.baseHeight = 36,
    this.iconSize = 18,
    this.radius = const BorderRadius.all(Radius.circular(4)),
    this.cardRadius = const BorderRadius.all(Radius.circular(6)),
    this.enableFeedback = false,
    this.globalDuration = const Duration(milliseconds: 250),
    this.themeDuration = const Duration(milliseconds: 100),
    this.themeCurve = Curves.linear,
    this.textStyle = const TextStyle(),
    this.buttonStyle = const ElButtonStyle(),
    this.linkStyle = const ElLinkStyle(),
    this.inputStyle = const ElInputStyle(),
    this.messageStyle = const ElMessageStyle(),
    this.toastStyle = const ElToastStyle(),
  });
}
