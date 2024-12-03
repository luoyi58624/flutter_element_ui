part of 'index.dart';

class _ElLayoutState extends State<ElLayout> {
  late BoxConstraints _constraints;
  late ElLayoutThemeData themeData;
  late ElLayoutData layoutData = ElLayoutData(
    navbarHeight: widget.navbar?.height ?? 0,
    sidebarWidth: widget.sidebar?.width ?? 0,
    rightSidebarWidth: widget.rightSidebar?.width ?? 0,
  );

  void updateSidebarWidth(double value) {
    setState(() {
      layoutData.sidebarWidth += value;
    });
  }

  void updateEndSidebarWidth() {
    setState(() {
      layoutData.sidebarWidth = calcSidebarWidth(layoutData.sidebarWidth);
    });
  }

  double calcSidebarWidth(double value) {
    return min(
      max(layoutData.sidebarWidth, widget.sidebar!.minWidth),
      widget.sidebar!.maxWidth ?? _constraints.maxWidth,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeData = ElLayoutTheme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      _constraints = constraints;
      List<Widget> children = [];
      double sidebarWidth = calcSidebarWidth(layoutData.sidebarWidth);

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
  }
}
