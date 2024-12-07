part of 'index.dart';

class ElLayoutState extends State<ElLayout> {
  late BoxConstraints _constraints;
  late ElLayoutThemeData _themeData;
  late final ModelObs<ElLayoutData> _layoutData; // 布局信息对象，对象会进行持久化
  ElLayoutData get layoutData => _layoutData.value;

  double _navbar = 0.0;
  double _sidebar = 0.0;
  double _rightSidebar = 0.0;
  double _footer = 0.0;

  Size get bodySize => Size(
        widget.body.minWidth ?? ElApp.of(context).responsive.xs,
        widget.body.minHeight,
      );

  double get footerHeight => min(
        max(layoutData.footer, widget.footer!.minHeight),
        widget.footer!.maxHeight ?? _constraints.maxWidth,
      );

  void _updateNavbar(double value) {
    _navbar += value;
    late double result;

    if (_navbar < widget.navbar!.minHeight) {
      result = widget.navbar!.minHeight;
    } else {
      final maxHeight =
          _constraints.maxHeight - layoutData.footer - bodySize.height;
      if (widget.navbar!.maxHeight != null) {
        result = min(_navbar, min(widget.navbar!.maxHeight!, maxHeight));
      } else {
        result = min(_navbar, maxHeight);
      }
    }
    if (_layoutData.value.navbar != result) {
      _layoutData.value = layoutData.copyWith(navbar: result);
    }
  }

  void _updateSidebar(double value) {
    _sidebar += value;
    late double result;

    if (_sidebar < widget.sidebar!.minWidth) {
      result = widget.sidebar!.minWidth;
    } else {
      final maxWidth =
          _constraints.maxWidth - layoutData.rightSidebar - bodySize.width;
      if (widget.sidebar!.maxWidth != null) {
        result = min(_sidebar, min(widget.sidebar!.maxWidth!, maxWidth));
      } else {
        result = min(_sidebar, maxWidth);
      }
    }
    if (_layoutData.value.sidebar != result) {
      _layoutData.value = layoutData.copyWith(sidebar: result);
    }
  }

  void _updateRightSidebar(double value) {
    _rightSidebar -= value;

    late double result;
    if (_rightSidebar < widget.rightSidebar!.minWidth) {
      result = widget.rightSidebar!.minWidth;
    } else {
      final maxWidth =
          _constraints.maxWidth - layoutData.sidebar - bodySize.width;
      if (widget.rightSidebar!.maxWidth != null) {
        result = min(
          _rightSidebar,
          min(widget.rightSidebar!.maxWidth!, maxWidth),
        );
      } else {
        result = min(_rightSidebar, maxWidth);
      }
    }
    if (_layoutData.value.rightSidebar != result) {
      _layoutData.value = layoutData.copyWith(rightSidebar: result);
    }
  }

  void _updateFooter(double value) {
    _footer -= value;
    late double result;

    if (_footer < widget.footer!.minHeight) {
      result = widget.footer!.minHeight;
    } else {
      final maxHeight =
          _constraints.maxHeight - layoutData.navbar - bodySize.height;
      if (widget.footer!.maxHeight != null) {
        result = min(_footer, min(widget.footer!.maxHeight!, maxHeight));
      } else {
        result = min(_footer, maxHeight);
      }
    }
    if (_layoutData.value.footer != result) {
      _layoutData.value = layoutData.copyWith(footer: result);
    }
  }

  /// 重置布局信息，同时清除本地缓存
  void resetLayout() {
    _layoutData.reset();
    _navbar = widget.navbar?.height ?? 0.0;
    _sidebar = widget.sidebar?.width ?? 0.0;
    _rightSidebar = widget.rightSidebar?.width ?? 0.0;
    _footer = widget.footer?.height ?? 0.0;
  }

  @override
  void initState() {
    super.initState();
    _layoutData = ModelObs(
      ElLayoutData(
        navbar: widget.navbar?.height ?? 0.0,
        sidebar: widget.sidebar?.width ?? 0.0,
        rightSidebar: widget.rightSidebar?.width ?? 0.0,
        footer: widget.footer?.height ?? 0.0,
      ),
      cacheKey: widget.cacheKey,
    );

    _navbar = layoutData.navbar;
    _sidebar = layoutData.sidebar;
    _rightSidebar = layoutData.rightSidebar;
    _footer = layoutData.footer;
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
    final splitResizerThemeData = ElSplitResizerTheme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      _constraints = constraints;

      return ObsBuilder(builder: (context) {
        List<Widget> children = [];

        children.add(
          Positioned(
            top: layoutData.navbar,
            bottom: 0,
            left: layoutData.sidebar,
            right: layoutData.rightSidebar,
            child: widget.body,
          ),
        );

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
                  width: layoutData.sidebar,
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
                left: layoutData.sidebar,
                child: ElSplitResizerTheme(
                  data: const ElSplitResizerThemeData(
                    position: ElSplitPosition.right,
                  ),
                  child: ElSplitResizer(
                    onChanged: _updateSidebar,
                    onEnd: () {
                      _sidebar = _layoutData.value.sidebar;
                    },
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
                right: layoutData.rightSidebar,
                child: ElSplitResizerTheme(
                  data: const ElSplitResizerThemeData(
                    position: ElSplitPosition.right,
                  ),
                  child: ElSplitResizer(
                    onChanged: _updateRightSidebar,
                    onEnd: () {
                      _rightSidebar = _layoutData.value.rightSidebar;
                    },
                  ),
                ),
              ),
            );
          }
        }
        if (widget.navbar != null) {
          final left = widget.sidebar?.expandedTop == true
              ? layoutData.sidebar + splitResizerThemeData.size!
              : 0.0;
          final right = widget.rightSidebar?.expandedTop == true
              ? layoutData.rightSidebar + splitResizerThemeData.size!
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
                top: layoutData.navbar,
                left: left,
                right: right,
                child: ElSplitResizerTheme(
                  data: const ElSplitResizerThemeData(
                    axis: Axis.horizontal,
                    position: ElSplitPosition.center,
                  ),
                  child: ElSplitResizer(
                    onChanged: _updateNavbar,
                    onEnd: () {
                      _navbar = _layoutData.value.navbar;
                    },
                  ),
                ),
              ),
            );
          }
        }
        if (widget.footer != null) {
          final left = widget.sidebar?.expandedBottom == true
              ? layoutData.sidebar + splitResizerThemeData.size!
              : 0.0;
          final right = widget.rightSidebar?.expandedBottom == true
              ? layoutData.rightSidebar + splitResizerThemeData.size!
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
                    onEnd: () {
                      _footer = _layoutData.value.footer;
                    },
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
