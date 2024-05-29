part of flutter_element_ui;

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
    final isHover = useState(false);
    return ElPlatform.isDesktop
        ? _HoverInheritedWidget(
            isHover: isHover.value,
            child: MouseRegion(
              onEnter: (onlyCursor || disabled) ? null : (event) => isHover.value = true,
              onExit: (onlyCursor || disabled) ? null : (event) => isHover.value = false,
              cursor: disabled ? SystemMouseCursors.forbidden : cursor,
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
