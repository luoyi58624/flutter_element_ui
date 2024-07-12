import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../service.dart';

class ElHover extends StatefulWidget {
  /// hover构建器，仅在桌面端渲染，移动端不会渲染
  const ElHover({
    super.key,
    required this.builder,
    this.cursor = SystemMouseCursors.click,
    this.disabled = false,
    this.onlyCursor = false,
  });

  final Widget Function(bool isHover) builder;

  /// 鼠标悬停光标样式，默认点击
  final MouseCursor cursor;

  /// 是否开启禁用样式，默认false
  final bool disabled;

  /// 是否仅更新显示的光标，但不触发状态，默认false
  final bool onlyCursor;

  /// 根据上下文获取最近的悬停状态
  static bool of(BuildContext context) => _HoverInheritedWidget.of(context);

  @override
  State<ElHover> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<ElHover> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return PlatformUtil.isDesktop
        ? _HoverInheritedWidget(
            isHover: isHover,
            child: MouseRegion(
              onHover: (event) => _update(true),
              onExit: (event) => _update(false),
              child: widget.builder(isHover),
            ),
          )
        : widget.builder(isHover);
  }

  void _update(bool value) {
    if (widget.disabled) {
      $el.cursor.value =
          value ? SystemMouseCursors.forbidden : MouseCursor.defer;
    } else {
      $el.cursor.value = value ? widget.cursor : MouseCursor.defer;
      if (!widget.onlyCursor && isHover != value) {
        setState(() {
          isHover = value;
        });
      }
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
