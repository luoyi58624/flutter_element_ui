import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

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

  /// 全局触觉回馈，默认false，如果为true，则所有点击事件将自动添加：HapticFeedback.mediumImpact();
  final bool enableFeedback;

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
    this.textStyle = const TextStyle(),
    this.buttonStyle = const ElButtonStyle(),
    this.linkStyle = const ElLinkStyle(),
    this.inputStyle = const ElInputStyle(),
    this.messageStyle = const ElMessageStyle(),
    this.toastStyle = const ElToastStyle(),
  });
}
