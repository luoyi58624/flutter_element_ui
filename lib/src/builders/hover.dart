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
    final $disabled = DragScrollbarDisabledHover.disabled(context);
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

/// 拖动滚动条滚动时禁用页面 hover 的效果，你必须自行重写[RawScrollbar]滚动条逻辑
class DragScrollbarDisabledHover extends StatefulWidget {
  const DragScrollbarDisabledHover({super.key, required this.child});

  final Widget child;

  /// 在App中插入监听滚动时禁用 hover 小部件
  static Widget Function(BuildContext, Widget?) builder([TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        Widget widget = DragScrollbarDisabledHover(child: child!);
        return builder == null ? widget : builder(context, widget);
      };

  /// 获取全局 hover 状态，如果用户拖动滚动条，页面元素将无法触发 hover 事件
  static bool disabled(BuildContext context) => _ScrollHoverInheritedWidget.maybeOf(context)?.disabled ?? false;

  /// 设置全局 hover 状态，此函数用于自定义滚动条
  static void setDisabled(BuildContext context, bool value) {
    _ScrollHoverInheritedWidget.maybeOf(context)?.setDisabled(value);
  }

  @override
  State<DragScrollbarDisabledHover> createState() => _DragScrollbarDisabledHoverState();
}

class _DragScrollbarDisabledHoverState extends State<DragScrollbarDisabledHover> {
  /// 如果用户拖动滚动条，将禁止当前滚动元素下的hover
  bool disabled = false;

  void setDisabled(bool value) {
    setState(() {
      disabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ScrollHoverInheritedWidget(
      disabled: disabled,
      setDisabled: setDisabled,
      child: widget.child,
    );
  }
}

class _ScrollHoverInheritedWidget extends InheritedWidget {
  const _ScrollHoverInheritedWidget({
    required super.child,
    required this.disabled,
    required this.setDisabled,
  });

  final bool disabled;
  final void Function(bool value) setDisabled;

  static _ScrollHoverInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ScrollHoverInheritedWidget>();

  @override
  bool updateShouldNotify(_ScrollHoverInheritedWidget oldWidget) => true;
}
