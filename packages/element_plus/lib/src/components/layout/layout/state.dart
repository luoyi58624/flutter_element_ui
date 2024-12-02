part of 'index.dart';

class _ElLayoutState extends State<ElLayout> {
  late ElLayoutThemeData themeData;
  late ElLayoutData layoutData;

  @override
  Widget build(BuildContext context) {
    themeData = ElLayoutTheme.of(context);
    layoutData = ElLayoutData(
      navbarHeight: widget.navbar?.height ?? 0,
      sidebarWidth: widget.sidebar?.width ?? 0,
      rightSidebarWidth: widget.rightSidebar?.width ?? 0,
    );

    List<Widget> children = [];

    if (widget.body != null) {
      children.add(
        Positioned(
          top: layoutData.navbarHeight,
          bottom: 0,
          left: layoutData.sidebarWidth,
          right: layoutData.rightSidebarWidth,
          child: widget.body!,
        ),
      );
    }
    if (widget.sidebar != null) {
      children.add(
        Positioned(
          top: widget.sidebar!.expandedTop ? 0 : layoutData.navbarHeight,
          bottom: 0,
          left: 0,
          child: ColoredBox(
            color: themeData.sidebarColor!,
            child: SizedBox(
              width: layoutData.sidebarWidth,
              child: widget.sidebar!,
            ),
          ),
        ),
      );
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
          left:
              widget.sidebar?.expandedTop == true ? layoutData.sidebarWidth : 0,
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
  }
}
