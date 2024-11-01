import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/services.dart';

part 'state.dart';

part 'behavior.dart';

part 'util.dart';

/// Element UI 滚动条显示模式
enum ElScrollbarMode {
  /// 不显示滚动条
  hidden,

  /// 当鼠标进入滚动区域立即显示滚动条，离开则立即隐藏滚动条 (默认)
  hover,

  /// 一直显示滚动条
  always,

  /// 只有当滚动时才显示滚动条
  onlyScrolling,
}

class ElScrollbar extends StatefulWidget {
  /// Element UI 滚动条，通常情况下使用 [ScrollConfiguration] 配置全局默认滚动行为，用户很少需要手动添加它
  const ElScrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thickness = 6.0,
    this.radius = const Radius.circular(3.0),
    this.mainAxisMargin = 0.0,
    this.crossAxisMargin = 1.0,
    this.minLength = 36.0,
    this.showTrack = false,
    this.mode = ElScrollbarMode.hover,
    this.trackColor,
    this.trackBorderColor,
    this.thumbColor = const Color.fromRGBO(144, 147, 153, .45),
    this.thumbHoverColor,
    this.thumbActiveColor,
    this.ignorePointer = false,
  });

  final Widget child;

  /// 滚动控制器
  final ScrollController? controller;

  /// 滚动条粗细值
  final double thickness;

  /// 滚动条圆角
  final Radius radius;

  /// 滚动条离顶部、尾部之间的间距，默认 0.0
  final double mainAxisMargin;

  /// 滚动条离轨道之间的间距，默认 1.0
  final double crossAxisMargin;

  /// 滚动条最小长度
  final double minLength;

  /// 是否显示轨道，默认 false
  final bool showTrack;

  /// 滚动条显示模式，默认 [ElScrollbarMode.hover]
  final ElScrollbarMode mode;

  /// 轨道颜色
  final Color? trackColor;

  /// 轨道边框颜色
  final Color? trackBorderColor;

  /// 滚动条颜色
  final Color thumbColor;

  /// 滚动条悬停颜色
  final Color? thumbHoverColor;

  /// 滚动条激活颜色
  final Color? thumbActiveColor;

  /// 滚动条是否忽略指针事件，默认 false
  final bool ignorePointer;

  @override
  State<ElScrollbar> createState() => _ElScrollbarState();
}
