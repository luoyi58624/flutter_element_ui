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

  /// 布局信息
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

  double get navbarHeight => min(
        max(layoutData.navbarHeight, widget.navbar!.minHeight),
        widget.navbar!.maxHeight ?? _constraints.maxHeight,
      );

  void updateNavbarHeight(double value) {
    _layoutData.value = _layoutData.value.copyWith(
      navbarHeight: _layoutData.value.navbarHeight + value,
    );
  }

  void updateEndNavbarHeight() {
    _layoutData.value = _layoutData.value.copyWith(
      navbarHeight: navbarHeight,
    );
  }

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

  double get rightSidebarWidth => min(
        max(layoutData.rightSidebarWidth, widget.rightSidebar!.minWidth),
        widget.rightSidebar!.maxWidth ?? _constraints.maxWidth,
      );

  void updateRightSidebarWidth(double value) {
    _layoutData.value = _layoutData.value.copyWith(
      rightSidebarWidth: _layoutData.value.rightSidebarWidth - value,
    );
  }

  void updateEndRightSidebarWidth() {
    _layoutData.value = _layoutData.value.copyWith(
      rightSidebarWidth: rightSidebarWidth,
    );
  }

  @override
  void didUpdateWidget(covariant ElLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool flag = false;
    if (widget.navbar != null) {
      if (oldWidget.navbar == null) {
        _layoutData.value.navbarHeight = widget.navbar!.height;
        flag = true;
      }
    } else {
      if (oldWidget.navbar != null) {
        _layoutData.value.navbarHeight = 0;
        flag = true;
      }
    }

    if (widget.sidebar != null) {
      if (oldWidget.sidebar == null) {
        _layoutData.value.sidebarWidth = widget.sidebar!.width;
        flag = true;
      }
    } else {
      if (oldWidget.sidebar != null) {
        _layoutData.value.sidebarWidth = 0;
        flag = true;
      }
    }

    if (widget.rightSidebar != null) {
      if (oldWidget.rightSidebar == null) {
        _layoutData.value.rightSidebarWidth = widget.rightSidebar!.width;
        flag = true;
      }
    } else {
      if (oldWidget.rightSidebar != null) {
        _layoutData.value.rightSidebarWidth = 0;
        flag = true;
      }
    }

    if (flag) _layoutData.notify();
  }

  @override
  void dispose() {
    super.dispose();
    _layoutData.dispose();
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
          final double top =
              widget.rightSidebar!.expandedTop ? 0 : layoutData.navbarHeight;
          children.add(
            Positioned(
              top: top,
              bottom: 0,
              right: 0,
              child: ColoredBox(
                color: themeData.sidebarColor!,
                child: SizedBox(
                  width: layoutData.rightSidebarWidth,
                  child: widget.rightSidebar!,
                ),
              ),
            ),
          );
          if (widget.rightSidebar!.enabledDrag) {
            children.add(
              Positioned(
                top: top,
                bottom: 0,
                right: rightSidebarWidth,
                child: ElSplitResizerTheme(
                  data: ElSplitResizerThemeData(
                    position: ElSplitPosition.right,
                    onChanged: updateRightSidebarWidth,
                    onEnd: updateEndRightSidebarWidth,
                  ),
                  child: const ElSplitResizer(),
                ),
              ),
            );
          }
        }
        if (widget.navbar != null) {
          final left = widget.sidebar?.expandedTop == true ? sidebarWidth : 0.0;
          final right = widget.rightSidebar?.expandedTop == true
              ? layoutData.rightSidebarWidth
              : 0.0;
          children.add(
            Positioned(
              left: left,
              right: right,
              child: Container(
                height: layoutData.navbarHeight,
                decoration: BoxDecoration(
                  color: themeData.navbarColor!,
                ),
                child: widget.navbar!,
              ),
            ),
          );
          if (widget.navbar!.enabledDrag) {
            children.add(
              Positioned(
                top: navbarHeight,
                left: left,
                right: right,
                child: ElSplitResizerTheme(
                  data: ElSplitResizerThemeData(
                    axis: Axis.horizontal,
                    position: ElSplitPosition.center,
                    onChanged: updateNavbarHeight,
                    onEnd: updateEndNavbarHeight,
                  ),
                  child: const ElSplitResizer(),
                ),
              ),
            );
          }
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
