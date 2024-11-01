import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:element_plus/src/global.dart';

part 'state.dart';

part 'behavior.dart';

class ElScrollbar extends RawScrollbar {
  /// Element UI 滚动条，特点是当鼠标进入滚动区域立即出现滚动条，离开滚动区域则立即消失
  const ElScrollbar({
    super.key,
    required super.child,
    this.always = false,
    this.hidden = false,
    this.onlyScrolling = false,
    this.hoverThumbColor,
    this.activeThumbColor,
    super.controller,
    super.thumbColor,
    super.thickness = _defaultThickness,
    super.radius = _defaultRadius,
    super.mainAxisMargin = 1.0,
    super.crossAxisMargin = 1.0,
    super.minThumbLength = 36.0,
    super.timeToFade,
  });

  /// 是否总是显示滚动条，默认情况下，当鼠标离开滚动区域时，滚动条将消失
  final bool always;

  /// 是否隐藏滚动条，若为true，任何事件都不会显示滚动条
  final bool hidden;

  /// 是否只有当滚动的时候才显示滚动条，停止滚动时将延迟一段时间隐藏，延迟时间为 [timeToFade]。
  ///
  /// 注意：此模式下 [thumbColor]、[hoverThumbColor] 都没有意义，要定义滚动条颜色请设置 [activeThumbColor]。
  final bool onlyScrolling;

  /// 鼠标悬停时，滚动条颜色，这是默认模式下的默认颜色，默认值为 [thumbColor] 的 0.45 透明度
  final Color? hoverThumbColor;

  /// 鼠标激活时，滚动条颜色，鼠标放在滚动条上的颜色，默认值为 [thumbColor] 的 0.9 透明度
  final Color? activeThumbColor;

  @override
  RawScrollbarState<ElScrollbar> createState() => _ElScrollbarState();
}
