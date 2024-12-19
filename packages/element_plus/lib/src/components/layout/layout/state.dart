part of 'index.dart';

class ElLayoutState extends State<ElLayout> {
  late BoxConstraints _constraints;

  /// 拖拽过程中保存的布局数据，所产生的数据不受布局约束
  late ElLayoutData _dragLayoutData;

  /// 支持本地持久化的最终布局数据
  late final ModelObs<ElLayoutData> _layoutData;

  ElLayoutData get layoutData => _layoutData.value;

  Size get bodySize => Size(
        widget.body.minWidth,
        widget.body.minHeight,
      );

  void _updateNavbar(double value) {
    _dragLayoutData.navbar += value;
    double result = _dragLayoutData.navbar;

    if (layoutData.footer + bodySize.height >= _constraints.maxHeight) {
      return;
    }
    if (result < widget.navbar!.minHeight) {
      result = widget.navbar!.minHeight;
    } else {
      final maxHeight =
          _constraints.maxHeight - layoutData.footer - bodySize.height;
      if (widget.navbar!.maxHeight != null) {
        result = min(result, min(widget.navbar!.maxHeight!, maxHeight));
      } else {
        result = min(result, maxHeight);
      }
    }
    if (_layoutData.value.navbar != result) {
      _layoutData.value = layoutData.copyWith(navbar: result);
    }
  }

  void _updateSidebar(double value) {
    _dragLayoutData.sidebar += value;
    double result = _dragLayoutData.sidebar;

    if (layoutData.rightSidebar + bodySize.width >= _constraints.maxWidth) {
      return;
    }
    if (result < widget.sidebar!.minWidth) {
      result = widget.sidebar!.minWidth;
    } else {
      final maxWidth =
          _constraints.maxWidth - layoutData.rightSidebar - bodySize.width;

      if (widget.sidebar!.maxWidth != null) {
        result = min(result, min(widget.sidebar!.maxWidth!, maxWidth));
      } else {
        result = min(result, maxWidth);
      }
    }
    if (layoutData.sidebar != result) {
      _layoutData.value = layoutData.copyWith(sidebar: result);
    }
  }

  void _updateRightSidebar(double value) {
    _dragLayoutData.rightSidebar -= value;

    double result = _dragLayoutData.rightSidebar;

    if (layoutData.sidebar + bodySize.width >= _constraints.maxWidth) {
      return;
    }
    if (result < widget.rightSidebar!.minWidth) {
      result = widget.rightSidebar!.minWidth;
    } else {
      final maxWidth =
          _constraints.maxWidth - layoutData.sidebar - bodySize.width;
      if (widget.rightSidebar!.maxWidth != null) {
        result = min(
          result,
          min(widget.rightSidebar!.maxWidth!, maxWidth),
        );
      } else {
        result = min(result, maxWidth);
      }
    }
    if (_layoutData.value.rightSidebar != result) {
      _layoutData.value = layoutData.copyWith(rightSidebar: result);
    }
  }

  void _updateFooter(double value) {
    _dragLayoutData.footer -= value;
    double result = _dragLayoutData.footer;

    if (layoutData.navbar + bodySize.height >= _constraints.maxHeight) {
      return;
    }
    if (result < widget.footer!.minHeight) {
      result = widget.footer!.minHeight;
    } else {
      final maxHeight =
          _constraints.maxHeight - layoutData.navbar - bodySize.height;
      if (widget.footer!.maxHeight != null) {
        result = min(result, min(widget.footer!.maxHeight!, maxHeight));
      } else {
        result = min(result, maxHeight);
      }
    }
    if (_layoutData.value.footer != result) {
      _layoutData.value = layoutData.copyWith(footer: result);
    }
  }

  /// 重置布局信息，同时清除本地缓存
  void resetLayout() {
    _layoutData.reset();
    _dragLayoutData = layoutData.copyWith();
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
    _dragLayoutData = layoutData.copyWith();
  }

  @override
  void didUpdateWidget(covariant ElLayout oldWidget) {
    super.didUpdateWidget(oldWidget);
    ElLayoutData newLayoutData = layoutData.copyWith();
    bool flag = false;

    if (widget.navbar != null) {
      if (oldWidget.navbar == null) {
        newLayoutData.navbar = widget.navbar!.height;
        flag = true;
      }
    } else {
      if (oldWidget.navbar != null) {
        newLayoutData.navbar = 0;
        flag = true;
      }
    }

    if (widget.sidebar != null) {
      if (oldWidget.sidebar == null) {
        newLayoutData.sidebar = widget.sidebar!.width;
        flag = true;
      }
    } else {
      if (oldWidget.sidebar != null) {
        newLayoutData.sidebar = 0;
        flag = true;
      }
    }

    if (widget.rightSidebar != null) {
      if (oldWidget.rightSidebar == null) {
        newLayoutData.rightSidebar = widget.rightSidebar!.width;
        flag = true;
      }
    } else {
      if (oldWidget.rightSidebar != null) {
        newLayoutData.rightSidebar = 0;
        flag = true;
      }
    }

    if (flag) {
      _layoutData.value = newLayoutData;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _layoutData.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splitResizerThemeData = ElSplitResizerTheme.of(context);
    return OverlayWidget(
      child: LayoutBuilder(builder: (context, constraints) {
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
            final top = widget.sidebar!.expandedTop ? 0.0 : layoutData.navbar;
            final bottom =
                widget.sidebar!.expandedBottom ? 0.0 : layoutData.footer;
            final bgColor =
                widget.sidebar!.bgColor ?? context.elTheme.sidebarColor;
            children.add(
              Positioned(
                top: top,
                bottom: bottom,
                left: 0,
                child: ColoredBox(
                  color: bgColor,
                  child: SizedBox(
                    width: layoutData.sidebar,
                    child: ElCurrentColor(
                      bgColor: bgColor,
                      child: widget.sidebar!,
                    ),
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
                        _dragLayoutData.sidebar = _layoutData.value.sidebar;
                      },
                    ),
                  ),
                ),
              );
            }
          }
          if (widget.rightSidebar != null) {
            final top =
                widget.rightSidebar!.expandedTop ? 0.0 : layoutData.navbar;
            final bottom =
                widget.rightSidebar!.expandedBottom ? 0.0 : layoutData.footer;
            final bgColor =
                widget.rightSidebar!.bgColor ?? context.elTheme.sidebarColor;
            children.add(
              Positioned(
                top: top,
                bottom: bottom,
                right: 0,
                child: ColoredBox(
                  color: bgColor,
                  child: SizedBox(
                    width: layoutData.rightSidebar,
                    child: ElCurrentColor(
                      bgColor: bgColor,
                      child: widget.rightSidebar!,
                    ),
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
                        _dragLayoutData.rightSidebar =
                            _layoutData.value.rightSidebar;
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
            final bgColor =
                widget.navbar!.bgColor ?? context.elTheme.navbarColor;
            children.add(
              Positioned(
                left: left,
                right: right,
                child: Container(
                  height: layoutData.navbar,
                  decoration: BoxDecoration(color: bgColor),
                  child: ElCurrentColor(
                    bgColor: bgColor,
                    child: widget.navbar!,
                  ),
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
                        _dragLayoutData.navbar = _layoutData.value.navbar;
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
            final bgColor =
                widget.footer!.bgColor ?? context.elTheme.footerColor;
            children.add(
              Positioned(
                left: left,
                right: right,
                bottom: 0,
                child: Container(
                  height: layoutData.footer,
                  decoration: BoxDecoration(color: bgColor),
                  child: ElCurrentColor(
                    bgColor: bgColor,
                    child: widget.footer!,
                  ),
                ),
              ),
            );
            if (widget.footer!.enabledDrag) {
              children.add(
                Positioned(
                  bottom: layoutData.footer,
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
                        _dragLayoutData.footer = _layoutData.value.footer;
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
      }),
    );
  }
}
