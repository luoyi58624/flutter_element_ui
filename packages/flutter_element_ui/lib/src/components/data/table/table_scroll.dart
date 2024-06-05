part of 'table.dart';

/// 表格非固定列、左固定列、右固定列三个区域的联动滚动
class _TableColumnScroll extends StatefulWidget {
  const _TableColumnScroll({
    required this.itemCount,
    this.itemBuilder,
    required this.controller,
    required this.linkageController,
    this.enableScrollbar = false,
    this.dragScroll = false,
  });

  final int itemCount;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final ScrollController controller;
  final List<ScrollController?> linkageController;
  final bool enableScrollbar;
  final bool dragScroll;

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
      key: ValueKey(widget.enableScrollbar || widget.dragScroll),
      behavior: _TableScrollBehavior(
        enableScrollbar: widget.enableScrollbar,
        dragScroll: widget.dragScroll,
      ),
      child: SuperListView.builder(
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
  final bool dragScroll;

  const _TableScrollBehavior({
    required this.enableScrollbar,
    this.dragScroll = false,
  });

  // @override
  // Set<PointerDeviceKind> get dragDevices => {
  //       PointerDeviceKind.touch,
  //       dragScroll ? PointerDeviceKind.mouse : PointerDeviceKind.unknown,
  //     };

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        assert(details.controller != null);
        return enableScrollbar
            ? Scrollbar(
                controller: details.controller,
                child: child,
              )
            : child;
    }
  }
}
