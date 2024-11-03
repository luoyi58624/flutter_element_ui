import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/services.dart';

part 'state.dart';

part 'mixin.dart';

part 'raw_mixin.dart';

part 'scrollbar_painter.dart';

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
  /// Element UI 滚动条，通常情况下使用 [ScrollConfiguration] 配置全局默认滚动行为，
  /// 用户很少需要手动添加它。
  const ElScrollbar({
    super.key,
    required this.child,
    this.controller,
    this.thickness = 6.0,
    this.shape,
    this.radius = const Radius.circular(3.0),
    this.trackRadius,
    this.mainAxisMargin = 0.0,
    this.crossAxisMargin = 1.0,
    this.minThumbLength = 36.0,
    this.showTrack = false,
    this.mode = ElScrollbarMode.hover,
    this.trackColor,
    this.trackBorderColor,
    this.thumbColor = const Color.fromRGBO(144, 147, 153, .45),
    this.thumbHoverColor,
    this.thumbActiveColor,
    this.interactive,
    this.fadeDuration = _kScrollbarFadeDuration,
    this.timeToFade = _kScrollbarTimeToFade,
  });

  final Widget child;

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

  /// 是否显示轨道，默认 true，只有当 [mode] == [ElScrollbarMode.always] 才生效
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

  /// 滚动条是否支持交互，默认 true
  final bool? interactive;

  /// 滚动条淡入、淡出过渡动画持续时间，默认 200 毫秒
  final Duration fadeDuration;

  /// 当交互停止时，滚动条多久才会隐藏，默认 1000 毫秒，
  /// 仅限 [mode] = [ElScrollbarMode.onlyScrolling]
  final Duration timeToFade;

  @override
  State<ElScrollbar> createState() => _ElScrollbarState();
}

class ElScrollBehavior extends CustomScrollBehavior {
  /// Element UI 默认的滚动行为，在桌面端默认使用 [ElScrollbar]
  const ElScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) {
    if (PlatformUtil.isWindows ||
        PlatformUtil.isMacOS ||
        PlatformUtil.isLinux) {
      return ElScrollbar(
        controller: details.controller,
        mode: ElScrollbarMode.hover,
        child: child,
      );
    }
    if (PlatformUtil.isIOS) {
      return CupertinoScrollbar(
        controller: details.controller,
        child: child,
      );
    }
    return Scrollbar(
      controller: details.controller,
      child: child,
    );
  }
}
