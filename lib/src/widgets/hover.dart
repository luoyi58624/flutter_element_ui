import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

class HoverBuilder extends StatefulWidget {
  /// hover构建器
  const HoverBuilder({
    super.key,
    required this.builder,
    this.cursor,
    this.disabled = false,
    this.onlyCursor = false,
    this.onEnter,
    this.onExit,
    this.onHover,
  });

  final WidgetBuilder builder;

  /// 鼠标悬停光标样式，默认点击
  final MouseCursor? cursor;

  /// 是否开启禁用样式，默认false
  final bool disabled;

  /// 是否仅更新显示的光标，但不触发状态
  final bool onlyCursor;

  /// 鼠标进入事件
  final PointerEnterEventListener? onEnter;

  /// 鼠标离开事件
  final PointerExitEventListener? onExit;

  /// hover事件
  final PointerHoverEventListener? onHover;

  /// 根据上下文获取最近的悬停状态
  static bool of(BuildContext context) =>
      _HoverInheritedWidget.of(context)?.isHover ?? false;

  /// 根据上下文获取最近的光标样式
  static MouseCursor? mouseCursor(BuildContext context) =>
      _HoverInheritedWidget.of(context)?.mouseCursor;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    // 仅限桌面端，移动端不存在hover
    if (PlatformUtil.isDesktop) {
      return _HoverInheritedWidget(
        isHover: isHover,
        mouseCursor:
            widget.disabled ? SystemMouseCursors.forbidden : widget.cursor,
        child: MouseRegion(
          cursor: widget.disabled
              ? SystemMouseCursors.forbidden
              : (widget.cursor ?? MouseCursor.defer),
          onHover: widget.disabled ? null : widget.onHover,
          onEnter: widget.disabled ? null : _onEnter,
          onExit: widget.disabled ? null : _onExit,
          child: Builder(builder: (context) {
            return widget.builder(context);
          }),
        ),
      );
    }
    return widget.builder(context);
  }

  void _onEnter(PointerEnterEvent event) {
    if (widget.onEnter != null) widget.onEnter!(event);
    if (!widget.onlyCursor && !isHover) {
      setState(() {
        isHover = true;
      });
    }
  }

  void _onExit(PointerExitEvent event) {
    if (widget.onExit != null) widget.onExit!(event);
    if (!widget.onlyCursor && isHover) {
      setState(() {
        isHover = false;
      });
    }
  }
}

class _HoverInheritedWidget extends InheritedWidget {
  const _HoverInheritedWidget({
    required super.child,
    required this.isHover,
    this.mouseCursor,
  });

  final bool isHover;
  final MouseCursor? mouseCursor;

  static _HoverInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_HoverInheritedWidget>();

  @override
  bool updateShouldNotify(_HoverInheritedWidget oldWidget) {
    return true;
  }
}
