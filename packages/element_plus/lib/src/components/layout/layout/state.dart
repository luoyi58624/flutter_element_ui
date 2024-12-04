part of 'index.dart';

class _LayoutDataSerialize implements ElSerialize<ElLayoutData> {
  const _LayoutDataSerialize();

  @override
  String? serialize(ElLayoutData? data) => jsonEncode(data?.toJson());

  @override
  ElLayoutData? deserialize(String? str) =>
      str == null ? null : ElLayoutData.fromJson(jsonDecode(str));
}

class _ElLayoutState extends State<ElLayout> {
  late BoxConstraints _constraints;
  late ElLayoutThemeData themeData;

  /// 布局信息，支持本地持久化
  late final _layoutData = LocalObs(
    ElLayoutData(
      navbarHeight: widget.navbar?.height ?? 0,
      sidebarWidth: widget.sidebar?.width ?? 0,
      rightSidebarWidth: widget.rightSidebar?.width ?? 0,
    ),
    cacheKey: widget.cacheKey,
    serialize: const _LayoutDataSerialize(),
  );

  ElLayoutData get layoutData => _layoutData.value;

  double get sidebarWidth => min(
        max(layoutData.sidebarWidth, widget.sidebar!.minWidth),
        widget.sidebar!.maxWidth ?? _constraints.maxWidth,
      );

  void updateSidebarWidth(double value) {
    _layoutData.value = _layoutData.value.copyWith(
      sidebarWidth: _layoutData.value.sidebarWidth + value,
    );
  }

  void updateEndSidebarWidth() {
    _layoutData.value = _layoutData.value.copyWith(
      sidebarWidth: sidebarWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    themeData = ElLayoutTheme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      _constraints = constraints;

      return ObsBuilder(builder: (context) {
        List<Widget> children = [];

        if (widget.body != null) {
          children.add(
            Positioned(
              top: layoutData.navbarHeight,
              bottom: 0,
              left: sidebarWidth,
              right: layoutData.rightSidebarWidth,
              child: widget.body!,
            ),
          );
        }
        if (widget.sidebar != null) {
          final double top =
              widget.sidebar!.expandedTop ? 0 : layoutData.navbarHeight;
          children.add(
            Positioned(
              top: top,
              bottom: 0,
              left: 0,
              child: ColoredBox(
                color: themeData.sidebarColor!,
                child: SizedBox(
                  width: sidebarWidth,
                  child: widget.sidebar!,
                ),
              ),
            ),
          );
          if (widget.sidebar!.enabledDrag) {
            children.add(
              Positioned(
                top: top,
                bottom: 0,
                left: sidebarWidth,
                child: ElSplitResizerTheme(
                  data: ElSplitResizerThemeData(
                    position: ElSplitPosition.right,
                    onChanged: updateSidebarWidth,
                    onEnd: updateEndSidebarWidth,
                  ),
                  child: const ElSplitResizer(),
                ),
              ),
            );
          }
        }
        if (widget.rightSidebar != null) {
          children.add(
            Positioned(
              top: layoutData.navbarHeight,
              bottom: 0,
              child: ColoredBox(
                color: themeData.sidebarColor!,
                child: SizedBox(
                  width: layoutData.rightSidebarWidth,
                  child: widget.rightSidebar!,
                ),
              ),
            ),
          );
        }
        if (widget.navbar != null) {
          children.add(
            Positioned(
              left: widget.sidebar?.expandedTop == true ? sidebarWidth : 0,
              right: widget.rightSidebar?.expandedTop == true
                  ? layoutData.rightSidebarWidth
                  : 0,
              child: ColoredBox(
                color: themeData.navbarColor!,
                child: SizedBox(
                  height: layoutData.navbarHeight,
                  child: widget.navbar!,
                ),
              ),
            ),
          );
        }
        return _LayoutInheritedWidget(
          layoutData,
          child: Stack(
            children: children,
          ),
        );
      });
    });
  }
}
