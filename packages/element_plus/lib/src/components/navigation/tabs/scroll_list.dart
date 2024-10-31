part of 'index.dart';

class _TabsScrollList extends HookWidget {
  const _TabsScrollList();

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final data = ElTabs.of(context);
    final theme = data.theme;
    final itemGap = theme.itemGap ?? 0.0;
    final enabledDrag = theme.enabledDrag ?? false;
    final delay = theme.dragDelay ?? const Duration(milliseconds: 100);

    return HorizontalScrollWidget(
      controller: scrollController,
      child: RawScrollbar(
        controller: scrollController,
        thickness: 3,
        radius: const Radius.circular(1.5),
        thumbColor: theme.thumbColor,
        child: ReorderableListView(
          scrollController: scrollController,
          scrollDirection: data.axis,
          buildDefaultDragHandles: false,
          autoScrollerVelocityScalar:
              theme.autoScrollerVelocityScalar ?? _autoScrollerVelocityScalar,
          proxyDecorator:
              theme.dragProxyDecorator ?? ElTabs.dragProxyDecorator(),
          onReorder: (int oldIndex, int newIndex) {
            if (data.onDragChanged != null) {
              final tempList = List<ElTab>.from(data.tabs);
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = tempList.removeAt(oldIndex);
              tempList.insert(newIndex, item);
              data.onDragChanged!(tempList);
            }
          },
          children: data.tabs.mapIndexed((i, e) {
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
        ).noScrollBehavior,
      ),
    );
  }
}
