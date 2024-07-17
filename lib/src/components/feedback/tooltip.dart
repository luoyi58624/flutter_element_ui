import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';

class ElTooltip extends StatefulWidget {
  const ElTooltip({
    super.key,
    required this.child,
    required this.content,
    this.bgColor,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final Widget content;
  final Color? bgColor;
  final Alignment alignment;

  @override
  State<ElTooltip> createState() => _ElTooltipState();
}

class _ElTooltipState extends State<ElTooltip> {
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;

  OverlayEntry createOverlay() {
    return OverlayEntry(builder: (context) {
      final bgColor = widget.bgColor ?? context.elTheme.primary;
      return UnconstrainedBox(
        child: CompositedTransformFollower(
          link: layerLink,
          targetAnchor: widget.alignment,
          followerAnchor: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(context.elConfig.radius),
            ),
            child: DefaultTextStyle.merge(
              style: TextStyle(
                color: bgColor.elTextColor(context),
                fontSize: 12,
              ),
              child: widget.content,
            ),
          ),
        ),
      );
    });
  }

  void insertOverlay() {
    if (overlayEntry == null) {
      overlayEntry = createOverlay();
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  void removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElHover(
      onlyCursor: true,
      onEnter: (e) {
        insertOverlay();
      },
      onExit: (e) {
        removeOverlay();
      },
      builder: (isHover) => CompositedTransformTarget(
        link: layerLink,
        child: widget.child,
      ),
    );
  }
}
