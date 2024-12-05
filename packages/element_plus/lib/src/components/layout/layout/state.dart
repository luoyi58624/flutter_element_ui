part of 'index.dart';

class _LayoutDataSerialize implements ElSerialize<ElLayoutData> {
  const _LayoutDataSerialize();

  @override
  String? serialize(ElLayoutData? data) => jsonEncode(data?.toJson());

  @override
  ElLayoutData? deserialize(String? str) =>
      str == null ? null : ElLayoutData.fromJson(jsonDecode(str));
}

class ElLayoutState extends State<ElLayout> {
  late BoxConstraints _constraints;
  late ElLayoutThemeData _themeData;

  /// 布局信息
  late final _layoutData = LocalObs(
    ElLayoutData(
      navbar: widget.navbar?.height ?? 0,
      sidebar: widget.sidebar?.width ?? 0,
      rightSidebar: widget.rightSidebar?.width ?? 0,
      footer: widget.footer?.height ?? 0,
    ),
    cacheKey: widget.cacheKey,
    serialize: const _LayoutDataSerialize(),
  );

  ElLayoutData get layoutData => _layoutData.value;

  double get navbarHeight => min(
        max(layoutData.navbar, widget.navbar!.minHeight),
        widget.navbar!.maxHeight ?? _constraints.maxHeight,
      );

  double get sidebarWidth => min(
        max(layoutData.sidebar, widget.sidebar!.minWidth),
        widget.sidebar!.maxWidth ?? _constraints.maxWidth,
      );

  double get rightSidebarWidth => min(
        max(layoutData.rightSidebar, widget.rightSidebar!.minWidth),
        widget.rightSidebar!.maxWidth ?? _constraints.maxWidth,
      );

  double get footerHeight => min(
        max(layoutData.footer, widget.footer!.minHeight),
        widget.footer!.maxHeight ?? _constraints.maxWidth,
      );

  void _updateNavbar(double value) {
    _layoutData.value = _layoutData.value.copyWith(
      navbar: _layoutData.value.navbar + value,
    );
  }

  void _updateEndNavbar() {
    _layoutData.value = _layoutData.value.copyWith(
      navbar: navbarHeight,
    );
  }

  void _updateSidebar(double value) {
    _layoutData.value = _layoutData.value.copyWith(
      sidebar: _layoutData.value.sidebar + value,
    );
  }

  void _updateEndSidebar() {
    _layoutData.value = _layoutData.value.copyWith(
      sidebar: sidebarWidth,
    );
  }

  void _updateRightSidebar(double value) {
    _layoutData.value = _layoutData.value.copyWith(
      rightSidebar: _layoutData.value.rightSidebar - value,
    );
  }

  void _updateEndRightSidebar() {
    _layoutData.value = _layoutData.value.copyWith(
      rightSidebar: rightSidebarWidth,
    );
  }

  void _updateFooter(double value) {
    _layoutData.value = _layoutData.value.copyWith(
      footer: _layoutData.value.footer - value,
    );
  }

  void _updateEndFooter() {
    _layoutData.value = _layoutData.value.copyWith(
      footer: footerHeight,
    );
  }

  /// 重置布局信息，同时清除本地缓存
  void resetLayout() {
    _layoutData.reset();
  }

  @override
  void didUpdateWidget(covariant ElLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool flag = false;
    if (widget.navbar != null) {
      if (oldWidget.navbar == null) {
        _layoutData.value.navbar = widget.navbar!.height;
        flag = true;
      }
    } else {
      if (oldWidget.navbar != null) {
        _layoutData.value.navbar = 0;
        flag = true;
      }
    }

    if (widget.sidebar != null) {
      if (oldWidget.sidebar == null) {
        _layoutData.value.sidebar = widget.sidebar!.width;
        flag = true;
      }
    } else {
      if (oldWidget.sidebar != null) {
        _layoutData.value.sidebar = 0;
        flag = true;
      }
    }

    if (widget.rightSidebar != null) {
      if (oldWidget.rightSidebar == null) {
        _layoutData.value.rightSidebar = widget.rightSidebar!.width;
        flag = true;
      }
    } else {
      if (oldWidget.rightSidebar != null) {
        _layoutData.value.rightSidebar = 0;
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
    _themeData = ElLayoutTheme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      _constraints = constraints;

      return ObsBuilder(builder: (context) {
        List<Widget> children = [];

        if (widget.body != null) {
          children.add(
            Positioned(
              top: layoutData.navbar,
              bottom: 0,
              left: sidebarWidth,
              right: layoutData.rightSidebar,
              child: widget.body!,
            ),
          );
        }
        if (widget.sidebar != null) {
          final double top =
              widget.sidebar!.expandedTop ? 0 : layoutData.navbar;
          final double bottom =
              widget.sidebar!.expandedBottom ? 0 : layoutData.footer;
          children.add(
            Positioned(
              top: top,
              bottom: bottom,
              left: 0,
              child: ColoredBox(
                color: _themeData.sidebarColor!,
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
                bottom: bottom,
                left: sidebarWidth,
                child: ElSplitResizerTheme(
                  data: const ElSplitResizerThemeData(
                    position: ElSplitPosition.right,
                  ),
                  child: ElSplitResizer(
                    onChanged: _updateSidebar,
                    onEnd: _updateEndSidebar,
                  ),
                ),
              ),
            );
          }
        }
        if (widget.rightSidebar != null) {
          final double top =
              widget.rightSidebar!.expandedTop ? 0 : layoutData.navbar;
          final double bottom =
              widget.rightSidebar!.expandedBottom ? 0 : layoutData.footer;
          children.add(
            Positioned(
              top: top,
              bottom: bottom,
              right: 0,
              child: ColoredBox(
                color: _themeData.sidebarColor!,
                child: SizedBox(
                  width: layoutData.rightSidebar,
                  child: widget.rightSidebar!,
                ),
              ),
            ),
          );
          if (widget.rightSidebar!.enabledDrag) {
            children.add(
              Positioned(
                top: top,
                bottom: bottom,
                right: rightSidebarWidth,
                child: ElSplitResizerTheme(
                  data: const ElSplitResizerThemeData(
                    position: ElSplitPosition.right,
                  ),
                  child: ElSplitResizer(
                    onChanged: _updateRightSidebar,
                    onEnd: _updateEndRightSidebar,
                  ),
                ),
              ),
            );
          }
        }
        if (widget.navbar != null) {
          final left = widget.sidebar?.expandedTop == true ? sidebarWidth : 0.0;
          final right = widget.rightSidebar?.expandedTop == true
              ? layoutData.rightSidebar
              : 0.0;
          children.add(
            Positioned(
              left: left,
              right: right,
              child: Container(
                height: layoutData.navbar,
                decoration: BoxDecoration(
                  color: _themeData.navbarColor!,
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
                  data: const ElSplitResizerThemeData(
                    axis: Axis.horizontal,
                    position: ElSplitPosition.center,
                  ),
                  child: ElSplitResizer(
                    onChanged: _updateNavbar,
                    onEnd: _updateEndNavbar,
                  ),
                ),
              ),
            );
          }
        }
        if (widget.footer != null) {
          final left =
              widget.sidebar?.expandedBottom == true ? sidebarWidth : 0.0;
          final right = widget.rightSidebar?.expandedBottom == true
              ? layoutData.rightSidebar
              : 0.0;
          children.add(
            Positioned(
              left: left,
              right: right,
              bottom: 0,
              child: Container(
                height: layoutData.footer,
                decoration: BoxDecoration(
                  color: _themeData.footerColor!,
                ),
                child: widget.footer!,
              ),
            ),
          );
          if (widget.footer!.enabledDrag) {
            children.add(
              Positioned(
                bottom: footerHeight,
                left: left,
                right: right,
                child: ElSplitResizerTheme(
                  data: const ElSplitResizerThemeData(
                    axis: Axis.horizontal,
                    position: ElSplitPosition.center,
                  ),
                  child: ElSplitResizer(
                    onChanged: _updateFooter,
                    onEnd: _updateEndFooter,
                  ),
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
