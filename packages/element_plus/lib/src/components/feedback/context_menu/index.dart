import 'package:element_plus/element_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../menu/index.dart';

class ElContextMenu extends StatefulWidget {
  /// 给目标小部件绑定右键事件，打开菜单
  const ElContextMenu({
    super.key,
    required this.child,
    required this.menu,
  });

  final Widget child;
  final Widget menu;

  @override
  State<ElContextMenu> createState() => _ElContextMenuState();
}

class _ElContextMenuState extends State<ElContextMenu> {
  OverlayState? overlay;
  OverlayEntry? overlayEntry;

  void insertMenu(Offset offset) {
    removeMenu();
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy,
        child: TapRegion(
          onTapOutside: (e) {
            removeMenu();
          },
          child: UnconstrainedBox(
            child: widget.menu,
          ),
        ),
      ),
    );

    overlay!.insert(overlayEntry!);
  }

  void removeMenu() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry!.dispose();
      overlayEntry = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    removeMenu();
  }

  @override
  Widget build(BuildContext context) {
    overlay ??= Overlay.of(context, rootOverlay: true);
    return ElEvent(
      onSecondaryTapDown: (e) {
        insertMenu(e.globalPosition);
      },
      child: widget.child,
    );
  }
}
