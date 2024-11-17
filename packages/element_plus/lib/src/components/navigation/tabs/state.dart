part of 'index.dart';

const _autoScrollerVelocityScalar = 100.0;

class _ElTabsState extends ElModelValueState<ElTabs, int> {
  final scrollController = ScrollController();
  late ElTabsThemeData theme;
  late Axis axis;
  PointerDownEvent? pointerDownEvent;

  void onChanged(int index) {
    modelValue = index;
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget builder(BuildContext context) {
    theme = ElTabsTheme.maybeOf(context) ?? context.elTheme.tabsTheme;
    axis = axisDirectionToAxis(theme.direction!);
    final builderWrapper = theme.builderWrapper ?? ElTabs.buildTabsWrapper();

    return ElTabsInheritedWidget(
      data: ElTabsData(
        activeIndex: modelValue,
        onChanged: onChanged,
      ),
      child: Builder(builder: (context) {
        return builderWrapper(context, buildScroll());
      }),
    );
  }

  Widget buildScroll() {
    final itemGap = theme.itemGap ?? 0.0;
    final enabledDrag = theme.enabledDrag ?? false;
    final builderScrollbar = theme.builderScrollbar ?? ElTabs.buildScrollbar();

    // 需要插入 Overlay 实例，防止拖拽的代理标签出现 context 作用域问题
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => HorizontalScrollWidget(
            controller: scrollController,
            child: builderScrollbar(
              context,
              scrollController,
              ReorderableList(
                controller: scrollController,
                scrollDirection: axis,
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
                onReorderStart: (e) {
                  el.cursor.add();
                },
                onReorderEnd: (e) {
                  el.cursor.remove();
                },
                itemCount: widget.tabs.length,
                itemBuilder: (context, index) {
                  final child = widget.tabs[index];
                  assert(child.key is ValueKey<int>,
                      'ElTab 必须设置 key，而且必须是 ValueKey<int> 类型，请检查是否正确设置它们');
                  final key = child.key as ValueKey<int>;
                  Widget result = child;
                  if (enabledDrag) {
                    if (itemGap > 0.0) {
                      result = Padding(
                        padding: EdgeInsets.only(
                          left: index == 0.0 ? 0.0 : itemGap,
                        ),
                        child: result,
                      );
                    }

                    final DeviceGestureSettings? gestureSettings =
                        MediaQuery.maybeGestureSettingsOf(context);
                    final SliverReorderableListState? list =
                        SliverReorderableList.maybeOf(context);

                    return ElEvent(
                      key: key,
                      onPointerDown: (e) {
                        onChanged(key.value);
                        pointerDownEvent = e;
                      },
                      onDragStart: (e) {
                        assert(pointerDownEvent != null);
                        list?.startItemDragReorder(
                          index: index,
                          event: pointerDownEvent!,
                          recognizer: DelayedMultiDragGestureRecognizer(
                            debugOwner: this,
                            delay: (PlatformUtil.isDesktop
                                ? const Duration(milliseconds: 0)
                                : kLongPressTimeout),
                          )..gestureSettings = gestureSettings,
                        );
                      },
                      child: result,
                    );
                  }
                  return Builder(
                    key: key,
                    builder: (context) => result,
                  );
                },
              ).noScrollBehavior,
            ),
          ),
        ),
      ],
    );
  }
}
