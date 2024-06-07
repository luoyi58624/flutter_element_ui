import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../utils/platform/platform.dart';

class ElHoverBuilder extends HookWidget {
  /// hover构建器，仅在桌面端渲染，移动端不会渲染
  const ElHoverBuilder({
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
  Widget build(BuildContext context) {
    final $disabled = ElGlobalHover.disabled(context);
    final isHover = useState(false);
    return ElPlatform.isDesktop
        ? _HoverInheritedWidget(
            isHover: isHover.value,
            child: MouseRegion(
              onEnter: ($disabled || onlyCursor || disabled) ? null : (event) => isHover.value = true,
              onExit: ($disabled || onlyCursor || disabled) ? null : (event) => isHover.value = false,
              cursor: $disabled
                  ? SystemMouseCursors.basic
                  : disabled
                      ? SystemMouseCursors.forbidden
                      : cursor,
              child: builder(isHover.value),
            ),
          )
        : builder(isHover.value);
  }
}

class _HoverInheritedWidget extends InheritedWidget {
  const _HoverInheritedWidget({
    required super.child,
    required this.isHover,
  });

  final bool isHover;

  static bool of(BuildContext context) {
    final _HoverInheritedWidget? result = context.dependOnInheritedWidgetOfExactType<_HoverInheritedWidget>();
    return result == null ? false : result.isHover;
  }

  @override
  bool updateShouldNotify(_HoverInheritedWidget oldWidget) {
    return true;
  }
}

/// 全局控制页面 hover 的效果
class ElGlobalHover extends StatefulWidget {
  const ElGlobalHover({super.key, required this.child});

  final Widget child;

  /// 是否全局禁用 hover 效果
  static bool disabled(BuildContext context) {
    return _DisabledHoverInheritedWidget.maybeOf(context)?.disabled ?? false;
  }

  /// 设置全局 hover 禁用状态
  static void setDisabled(BuildContext context, bool value) {
    _DisabledHoverInheritedWidget.maybeOf(context)?.setDisabled(value);
  }

  @override
  State<ElGlobalHover> createState() => _ElGlobalHoverState();
}

class _ElGlobalHoverState extends State<ElGlobalHover> {
  bool disabled = false;

  void setDisabled(bool value) {
    setState(() {
      disabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _DisabledHoverInheritedWidget(
      disabled: disabled,
      setDisabled: setDisabled,
      child: widget.child,
    );
  }
}

class _DisabledHoverInheritedWidget extends InheritedWidget {
  const _DisabledHoverInheritedWidget({
    required super.child,
    required this.disabled,
    required this.setDisabled,
  });

  final bool disabled;
  final void Function(bool value) setDisabled;

  static _DisabledHoverInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_DisabledHoverInheritedWidget>();

  @override
  bool updateShouldNotify(_DisabledHoverInheritedWidget oldWidget) => true;
}
