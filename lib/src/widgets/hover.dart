import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../core.dart';

class HoverBuilder extends StatefulWidget {
  /// hover构建器
  const HoverBuilder({
    super.key,
    required this.builder,
    this.cursor = MouseCursor.defer,
    this.disabled = false,
    this.onlyCursor = false,
    this.onEnter,
    this.onExit,
    this.onHover,
  });

  final WidgetBuilder builder;

  /// 鼠标悬停光标样式，默认点击
  final MouseCursor cursor;

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
  static bool of(BuildContext context) => _HoverInheritedWidget.of(context);

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return _HoverInheritedWidget(
      isHover: isHover,
      child: MouseRegion(
        onEnter: _onEnter,
        onExit: _upExit,
        onHover: widget.disabled ? null : widget.onHover,
        child: Builder(builder: (context) {
          return widget.builder(context);
        }),
      ),
    );
  }

  void _onEnter(PointerEnterEvent event) {
    if (widget.disabled) {
      el.setCursor(SystemMouseCursors.forbidden);
    } else {
      if (widget.onEnter != null) widget.onEnter!(event);
      bool flag = el.setCursor(widget.cursor);
      if (flag && !isHover) {
        if (!widget.onlyCursor) {
          setState(() {
            isHover = true;
          });
        }
      }
    }
  }

  void _upExit(PointerExitEvent event) {
    if (widget.onExit != null) widget.onExit!(event);
    bool flag = el.resetCursor();
    if (flag && isHover && !widget.onlyCursor) {
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
  });

  final bool isHover;

  static bool of(BuildContext context) {
    final _HoverInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_HoverInheritedWidget>();
    return result == null ? false : result.isHover;
  }

  @override
  bool updateShouldNotify(_HoverInheritedWidget oldWidget) {
    return true;
  }
}
