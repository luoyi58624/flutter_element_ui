part of 'index.dart';

const _autoScrollerVelocityScalar = 100.0;

class _ElTabsState extends ElModelValueState<ElTabs, int> {
  final scrollController = ScrollController();
  late ElTabsThemeData theme;
  late Axis axis;

  @override
  Widget builder(BuildContext context) {
    theme = ElTabsTheme.maybeOf(context) ?? context.elTheme.tabsTheme;
    final size = theme.size ?? 36;
    final bgColor = theme.bgColor!;
    final direction = theme.direction ?? AxisDirection.right;
    axis = axisDirectionToAxis(direction);
    final builder =
        theme.builder ?? (context, child) => ElTabsWrapper(child: child);

    return ElTabsInheritedWidget(
      data: ElTabsData(
        activeIndex: modelValue,
        size: size,
        direction: direction,
        axis: axis,
        bgColor: bgColor,
      ),
      child: Builder(builder: (context) {
        return builder(context, buildScroll());
      }),
    );
  }

  Widget buildScroll() {
    final itemGap = theme.itemGap ?? 0.0;
    final enabledDrag = theme.enabledDrag ?? false;
    final delay = PlatformUtil.isDesktop
        ? (theme.dragDelay ?? desktopDragTimeout)
        : kLongPressTimeout;
    // 目前需要插入 Overlay 实例，防止拖拽的代理标签出现 context 作用域问题
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => HorizontalScrollWidget(
            controller: scrollController,
            child: RawScrollbar(
              controller: scrollController,
              thickness: 3,
              radius: const Radius.circular(1.5),
              thumbColor: theme.thumbColor,
              child: ReorderableListView(
                scrollController: scrollController,
                scrollDirection: axis,
                buildDefaultDragHandles: false,
                autoScrollerVelocityScalar: theme.autoScrollerVelocityScalar ??
                    _autoScrollerVelocityScalar,
                proxyDecorator:
                    theme.dragProxyDecorator ?? ElTabs.dragProxyDecorator(),
                onReorder: (int oldIndex, int newIndex) {
                  if (widget.onDragChanged != null) {
                    final tempList = List<ElTab>.from(widget.tabs);
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final item = tempList.removeAt(oldIndex);
                    tempList.insert(newIndex, item);
                    widget.onDragChanged!(tempList);
                  }
                },
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
              ).noScrollBehavior,
            ),
          ),
        ),
      ],
    );
  }
}
