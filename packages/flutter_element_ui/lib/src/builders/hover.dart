import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

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
    return PlatformUtil.isDesktop
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

class ElGlobalHover extends StatefulWidget {
  /// 全局控制页面 hover 的效果，该组件目前配合[ElScrollConfiguration]使用，
  /// 默认情况下，当用户拖动滚动条时，鼠标依旧会触发hover效果，这种行为在 Web 上是不会存在的，
  /// 所以，ElScrollbar对此行为做了处理，当用户开始拖动滚动条时，会尝试获取[ElGlobalHover]组件并设置全局禁用，
  /// [ElHoverBuilder]触发hover时会优先判断全局状态，防止用户拖动滚动条时触发元素hover
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
