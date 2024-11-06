import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';

part 'state.dart';

part 'mixin.dart';

part 'raw_mixin.dart';

part 'scrollbar_painter.dart';

/// Element UI 滚动条显示模式
enum ElScrollbarMode {
  /// 不显示滚动条
  hidden,

  /// 当鼠标进入滚动区域立即显示滚动条，离开则立即隐藏
  hover,

  /// 一直显示滚动条
  always,

  /// 只有当滚动时才显示滚动条
  onlyScrolling,
}

class ElScrollbar extends StatefulWidget {
  /// Element UI 滚动条，由于可以通过 [ScrollConfiguration] 配置默认滚动条，所以并未提供 ThemeData 配置
  const ElScrollbar({
    super.key,
    required this.child,
    this.mode = ElScrollbarMode.hover,
    this.controller,
    this.thickness = 6.0,
    this.shape,
    this.radius = const Radius.circular(3.0),
    this.trackRadius,
    this.mainAxisMargin = 0.0,
    this.crossAxisMargin = 1.0,
    this.minThumbLength = 36.0,
    this.trackColor = Colors.transparent,
    this.trackBorderColor = Colors.transparent,
    this.trackBorderWidth = 1.0,
    this.thumbColor = const Color.fromRGBO(144, 147, 153, .45),
    this.thumbActiveColor = const Color.fromRGBO(144, 147, 153, .9),
    this.interactive = true,
    this.trackInteractive = true,
    this.fadeDuration = const Duration(milliseconds: 200),
    this.timeToFade = const Duration(milliseconds: 1000),
    this.trackScrollDuration = const Duration(milliseconds: 350),
  });

  final Widget child;

  /// 滚动条显示模式，默认 [ElScrollbarMode.hover]
  final ElScrollbarMode mode;

  /// 滚动控制器
  final ScrollController? controller;

  /// 滚动条粗细值
  final double thickness;

  /// 自定义滚动条形状，只能在 [radius] 之间二选一
  final OutlinedBorder? shape;

  /// 滚动条圆角
  final Radius radius;

  /// 滚动轨道圆角
  final Radius? trackRadius;

  /// 滚动条离顶部、尾部之间的间距，默认 0.0
  final double mainAxisMargin;

  /// 滚动条离轨道之间的间距，默认 1.0
  final double crossAxisMargin;

  /// 滚动条最小长度
  final double minThumbLength;

  /// 轨道颜色，默认透明
  final Color trackColor;

  /// 轨道边框颜色，默认透明
  final Color trackBorderColor;

  /// 轨道边框宽度
  final double trackBorderWidth;

  /// 滚动条颜色
  final Color thumbColor;

  /// 滚动条激活颜色
  final Color thumbActiveColor;

  /// 滚动条是否支持交互，默认 true
  final bool interactive;

  /// 轨道是否支持交互，默认 true，点击轨道将滚动到目标位置
  final bool trackInteractive;

  /// 滚动条淡入、淡出过渡动画持续时间
  final Duration fadeDuration;

  /// 当交互停止时，滚动条多久才会隐藏，仅限 [mode] = [ElScrollbarMode.onlyScrolling]
  final Duration timeToFade;

  /// 点击轨道滚动跳转动画持续时间
  final Duration trackScrollDuration;

  @override
  State<ElScrollbar> createState() => _ElScrollbarState();
}

class ElScrollBehavior extends CustomScrollBehavior {
  /// Element UI 默认滚动行为，在桌面端使用 [ElScrollbar]，移动端则使用官方实现的 [Scrollbar]
  const ElScrollBehavior({
    this.showTrack = false,
    this.trackWidth = 10.0,
  });

  /// 是否显示滚动轨道，默认 false
  final bool showTrack;

  /// 滚动轨道宽度，默认 10
  final double trackWidth;

  @override
  Widget buildScrollbar(context, child, details) {
    if (PlatformUtil.isWindows ||
        PlatformUtil.isMacOS ||
        PlatformUtil.isLinux) {
      if (showTrack) {
        return ElScrollbar(
          controller: details.controller,
          mode: ElScrollbarMode.always,
          thickness: trackWidth,
          radius: Radius.circular(trackWidth / 2),
          crossAxisMargin: 2.0,
          thumbColor: context.isDark
              ? const Color.fromRGBO(125, 125, 125, 1.0)
              : const Color.fromRGBO(193, 193, 193, 1.0),
          thumbActiveColor: context.isDark
              ? const Color.fromRGBO(193, 193, 193, 1.0)
              : const Color.fromRGBO(125, 125, 125, 1.0),
          trackBorderColor: context.isDark ? Colors.white30 : Colors.black12,
          child: child,
        );
      } else {
        return ElScrollbar(
          controller: details.controller,
          child: child,
        );
      }
    }
    return ElScrollbar(
      controller: details.controller,
      mode: ElScrollbarMode.onlyScrolling,
      child: child,
    );
  }
}
