part of flutter_element_ui;

class _TableColumnScroll extends StatefulWidget {
  const _TableColumnScroll({
    this.child,
    required this.itemCount,
    this.itemBuilder,
    required this.controller,
    required this.linkageController,
    this.enableScrollbar = false,
  });

  final Widget? child;
  final int itemCount;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final ScrollController controller;
  final List<ScrollController?> linkageController;
  final bool enableScrollbar;

  @override
  State<_TableColumnScroll> createState() => _TableColumnScrollState();
}

class _TableColumnScrollState extends State<_TableColumnScroll> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      widget.linkageController.forEach((controller) {
        if (controller != null && controller.offset != widget.controller.offset) {
          controller.jumpTo(widget.controller.offset);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      key: ValueKey(widget.enableScrollbar),
      behavior: _TableScrollBehavior(enableScrollbar: widget.enableScrollbar),
      child: widget.child != null
          ? SingleChildScrollView(
              controller: widget.controller,
              physics: const ClampingScrollPhysics(),
              child: widget.child,
            )
          : SuperListView.builder(
              controller: widget.controller,
              itemCount: widget.itemCount,
              physics: const ClampingScrollPhysics(),
              itemBuilder: widget.itemBuilder!,
            ),
    );
  }
}

class _TableScrollBehavior extends ScrollBehavior {
  final bool enableScrollbar;

  const _TableScrollBehavior({required this.enableScrollbar});

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        assert(details.controller != null);
        return enableScrollbar
            ? Scrollbar(
                controller: details.controller,
                child: child,
              )
            : child;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }
}
