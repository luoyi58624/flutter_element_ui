part of 'index.dart';

class _DialogRoute<T> extends TransitionRoute<T> {
  _DialogRoute({
    required this.overlayContext,
    required this.themeData,
    required this.modalColor,
    required this.draggable,
    required this.closeOnClickModal,
    required this.closeOnClickOutside,
    required this.allowInteractive,
  });

  final BuildContext overlayContext;
  final ElDialogThemeData themeData;
  final Color modalColor;
  final bool draggable;
  final bool closeOnClickModal;
  final bool closeOnClickOutside;
  final bool allowInteractive;

  @override
  bool get opaque => false;

  @override
  bool get popGestureEnabled => true;

  @override
  Duration get transitionDuration => themeData.animationDuration;

  late final Animation<Offset> positionAnimation = Tween<Offset>(
    begin: const Offset(0, -0.1),
    end: const Offset(0, 0),
  ).animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

  void closeDialog() {
    Navigator.of(overlayContext).pop();
  }

  Widget buildModalWidget() {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: allowInteractive,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: closeOnClickModal == false
              ? null
              : () {
                  Navigator.of(overlayContext).pop();
                },
          child: FadeTransition(
            opacity: animation!,
            child: ColoredBox(
              color: modalColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDialogWidget() {
    Widget result = _DialogWidget(
      overlayContext: overlayContext,
      themeData: themeData,
    );
    if (closeOnClickOutside) {
      result = TapRegion(
        onTapOutside: (e) {
          closeDialog();
        },
        child: result,
      );
    }

    return Positioned.fill(
      child: UnconstrainedBox(
        child: SlideTransition(
          position: positionAnimation,
          child: FadeTransition(
            opacity: animation!,
            child: result,
          ),
        ),
      ),
    );
  }

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return [
      if (modalColor != Colors.transparent)
        OverlayEntry(builder: (context) => buildModalWidget()),
      OverlayEntry(builder: (context) => buildDialogWidget()),
    ];
  }
}
