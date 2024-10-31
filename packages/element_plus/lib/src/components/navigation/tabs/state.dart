part of 'index.dart';

const _autoScrollerVelocityScalar = 100.0;

class _ElTabsState extends ElModelValueState<ElTabs, int> {
  @override
  Widget builder(BuildContext context) {
    final theme = ElTabsTheme.maybeOf(context) ?? context.elTheme.tabsTheme;
    final size = theme.size ?? 36;
    final bgColor = theme.bgColor!;
    final direction = theme.direction ?? AxisDirection.right;
    final axis = axisDirectionToAxis(direction);
    final builder =
        theme.builder ?? (context, child) => ElTabsWrapper(child: child);

    return ElTabsInheritedWidget(
      data: ElTabsData(
        activeIndex: modelValue,
        theme: theme,
        size: size,
        direction: direction,
        axis: axis,
        bgColor: bgColor,
        tabs: widget.tabs,
        onDragChanged: widget.onDragChanged,
      ),
      child: builder(
        context,
        const _TabsScrollList(),
      ),
    );
  }
}
