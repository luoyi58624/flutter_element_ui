import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../services/service.dart';

const double _defaultThickness = 6.0;
const Radius _defaultRadius = Radius.circular(3.0);
const int _duration = 200;

class ElScrollBehavior extends CustomScrollBehavior {
  /// 设置全局默认的滚动条，桌面端使用[ElScrollbar]
  const ElScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) {
    if (PlatformUtil.isWindows ||
        PlatformUtil.isMacOS ||
        PlatformUtil.isLinux) {
      return ElScrollbar(
        controller: details.controller,
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

class ElScrollbar extends RawScrollbar {
  /// Element UI 滚动条，特点是当鼠标进入滚动区域立即出现滚动条，离开滚动区域则立即消失，
  /// 因为它完全依赖于 hover 事件，所以此滚动条只适合桌面平台，对于移动端请使用默认的[Scrollbar]
  const ElScrollbar({
    super.key,
    required super.child,
    this.always = false,
    super.controller,
    super.thumbColor,
    super.thickness = _defaultThickness,
    super.radius = _defaultRadius,
    super.mainAxisMargin = 1.0,
    super.crossAxisMargin = 1.0,
    super.minThumbLength = 36.0,
  });

  /// 是否总是显示滚动条，默认情况下，当鼠标离开滚动区域时，滚动条将消失
  final bool always;

  @override
  RawScrollbarState<ElScrollbar> createState() => _ElScrollbarState();
}

class _ElScrollbarState extends RawScrollbarState<ElScrollbar> {
  /// 创建滚动条动画控制器
  late AnimationController controller;

  /// 对滚动条颜色变化进行线性插值，定义两个变量用于保存当前滚动条颜色和目标颜色
  Color? color1;
  Color? color2;

  /// 当鼠标进入滚动区域时立即显示滚动条
  bool isHover = false;

  /// 鼠标悬停在滚动条上
  bool isScrollbarHover = false;

  /// 是否处于拖拽滚动条状态
  bool isDragScroll = false;

  /// 覆写 [RawScrollbar] 显示滚动默认逻辑，如何显示滚动条由自己做决定
  @override
  bool get showScrollbar => true;

  /// 滚动条颜色
  Color get thumbColor =>
      widget.thumbColor ?? const Color.fromRGBO(144, 147, 153, 1.0);

  /// 鼠标进入滚动范围显示的颜色
  Color get hoverThumbColor => thumbColor.withOpacity(0.5);

  /// 鼠标悬停在滚动轨道的颜色
  Color get activeThumbColor => thumbColor.withOpacity(0.9);

  /// 默认情况下，滚动条是处于隐藏状态，但如果开启一直显示，则置为悬停状态
  Color get hideThumbColor =>
      widget.always ? hoverThumbColor : thumbColor.withOpacity(0);

  /// 对滚动条颜色进行线性插值
  Color get scrollbarColor {
    if (color1 == null || color2 == null) return hideThumbColor;
    return Color.lerp(color1, color2, controller.value)!;
  }

  /// color1 -> color2
  void changeColor(Color color1, Color color2) {
    this.color1 = color1;
    this.color2 = color2;
    // i('xx');
    // if (color1 == activeThumbColor) {
    //   i('color1');
    // }
    // if (color2 == activeThumbColor) {
    //   i('color2');
    // }
    controller.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: _duration.ms,
    )..addListener(updateScrollbarPainter);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ElScrollbar oldWidget) {
    updateScrollbarPainter();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = scrollbarColor
      ..textDirection = Directionality.of(context)
      ..thickness = widget.thickness ?? _defaultThickness
      ..radius = widget.radius ?? _defaultRadius
      ..mainAxisMargin = widget.mainAxisMargin
      ..crossAxisMargin = widget.crossAxisMargin;
  }

  /// 开始拖动滚动条
  @override
  void handleThumbPressStart(Offset localPosition) {
    super.handleThumbPressStart(localPosition);
    el.setCursor();
    isDragScroll = true;
    // 处理直接从边缘处立即拖动滚动条，这只是一个细节处理
    // if (isScrollbarHover == false) {
    //   color1 = isHover ? hoverThumbColor : hideThumbColor;
    //   color2 = activeThumbColor;
    //   controller.forward(from: 0);
    // }
  }

  /// 结束拖动滚动条
  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    super.handleThumbPressEnd(localPosition, velocity);
    el.resetCursor();
    _delayHandlerPressEnd = () {
      _delayHandlerPressEnd = null;
      isDragScroll = false;
      if (isScrollbarHover == false) {
        if (isHover) {
          changeColor(activeThumbColor, hoverThumbColor);
        } else {
          // 结束滚动条拖动时如果鼠标已经处于页面之外，那么将隐藏滚动条，否则将滚动条状态设置为hover
          changeColor(activeThumbColor, hideThumbColor);
        }
      }
    }.delay(_duration);
  }

  /// 延迟激活悬停滚动条，当用户快速从滚动条上划过时，不会对滚动条进行高亮
  Timer? _delayActiveHover;

  void _cancelDelayActiveHover() {
    if (_delayActiveHover != null) {
      _delayActiveHover!.cancel();
      _delayActiveHover = null;
    }
  }

  /// 延迟处理拖拽结束事件，由于拖拽滚动条会执行 [el.setCursor] 创建一层全局遮罩，
  /// 会导致触发 [handleHoverExit] 事件，所以释放拖拽滚动条时，必须延迟执行内部逻辑
  Timer? _delayHandlerPressEnd;

  /// 鼠标在滚动区域悬停事件
  @override
  void handleHover(PointerHoverEvent event) {
    super.handleHover(event);
    // 优先处理鼠标悬停在滚动条上的事件
    if (isPointerOverThumb(event.position, event.kind)) {
      if (isScrollbarHover == false) {
        // 延迟设置悬停状态，当鼠标快速划过时不要将其更新为激活状态
        _delayActiveHover = () {
          isScrollbarHover = true;
          changeColor(hoverThumbColor, activeThumbColor);
        }.delay(100);
      }
    }
    // 如果是从滚动条上挪开，则将滚动条颜色从active变回hover
    else if (isScrollbarHover) {
      isScrollbarHover = false;
      changeColor(activeThumbColor, hoverThumbColor);
    } else {
      _cancelDelayActiveHover();
    }
  }

  /// 鼠标离开滚动区域事件
  @override
  void handleHoverExit(PointerExitEvent event) {
    isHover = false;
    isScrollbarHover = false;
    super.handleHoverExit(event);
    if (isDragScroll) return;
    _cancelDelayActiveHover();
    changeColor(color2!, hideThumbColor);
  }

  /// [RawScrollbar]没有提供监听[onEnter]事件，导致当鼠标离开滚动区域时，无法监听是否重新回到滚动区域，所以只能再套一层[MouseRegion]
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        if (isHover == false) {
          isHover = true;
          if (isDragScroll) {
            if (isPointerOverThumb(event.position, event.kind)) {
              isScrollbarHover = true;
            }
          } else {
            changeColor(hideThumbColor, hoverThumbColor);
          }
        }
      },
      child: super.build(context),
    );
  }
}
