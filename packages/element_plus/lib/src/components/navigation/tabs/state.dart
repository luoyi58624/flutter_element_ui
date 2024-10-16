part of 'index.dart';

class _ElTabsState extends ElModelValueState<ElTabs, int>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();

  /// 触发拖拽排序事件
  void _onReorder(int oldIndex, int newIndex) {
    if (widget.onDragChanged != null) {
      final tempList = List<ElTab>.from(widget.tabs);
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = tempList.removeAt(oldIndex);
      tempList.insert(newIndex, item);
      widget.onDragChanged!(tempList);
    }
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double scale = lerpDouble(1, 1.15, animValue)!;
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Widget builder(BuildContext context) {
    final theme = ElTabsTheme.of(context);
    final size = theme.size ?? 50;
    final itemGap = theme.itemGap ?? 0.0;
    final enabledDrag = theme.enabledDrag ?? false;
    final delay = theme.dragDelay ?? const Duration(milliseconds: 100);
    final direction = theme.direction ?? AxisDirection.right;
    final axis = axisDirectionToAxis(direction);

    Widget result = SizedBox(
      width: axis == Axis.vertical ? size : null,
      height: axis == Axis.horizontal ? size : null,
      child: HorizontalScrollWidget(
        controller: scrollController,
        child: ReorderableListView(
          scrollController: scrollController,
          scrollDirection: axis,
          buildDefaultDragHandles: false,
          autoScrollerVelocityScalar: 500,
          proxyDecorator: proxyDecorator,
          onReorder: _onReorder,
          children: widget.tabs.mapIndexed((i, e) {
            Widget result = e;
            if (enabledDrag) {
              if (itemGap > 0.0) {
                result = Padding(
                  padding: EdgeInsets.only(
                    left: i == 0.0 ? 0.0 : itemGap,
                  ),
                  child: result,
                );
              }
              result = DragStartListener(
                index: i,
                delay: delay,
                child: result,
              );
            }
            return Builder(
              key: ValueKey(i),
              builder: (context) => result,
            );
          }).toList(),
        ).cupertinoScrollBehavior,
      ),
    );

    return TabsInheritedWidget(
      prop: TabsProp(
        themeData: theme,
        activeIndex: modelValue,
      ),
      child: result,
    );
  }
}
