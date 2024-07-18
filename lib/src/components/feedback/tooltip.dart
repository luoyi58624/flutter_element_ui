import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

class ElTooltip extends StatefulWidget {
  const ElTooltip({
    super.key,
    required this.child,
    required this.content,
    this.bgColor,
    this.selected = false,
  });

  final Widget child;
  final dynamic content;
  final Color? bgColor;

  /// 文字是否可选中
  final bool selected;

  @override
  State<ElTooltip> createState() => _ElTooltipState();
}

class _ElTooltipState extends State<ElTooltip> {
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  RenderBox? renderBox;
  Timer? _delayRemove;

  @override
  void initState() {
    super.initState();
  }

  OverlayEntry createOverlay() {
    renderBox = context.findRenderObject() as RenderBox;
    return OverlayEntry(builder: (context) {
      return buildOverlayWidget(context);
    });
  }

  void insertOverlay() {
    if (_delayRemove != null) {
      _delayRemove!.cancel();
      _delayRemove = null;
    } else {
      if (overlayEntry == null) {
        overlayEntry = createOverlay();
        Overlay.of(context).insert(overlayEntry!);
      }
    }
  }

  void removeOverlay() {
    _delayRemove = null;
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  Widget buildOverlayWidget(BuildContext context) {
    assert(renderBox != null, 'ElTooltip渲染对象为null，这是 Element UI 内部 bug');
    Offset offset = renderBox!.localToGlobal(Offset.zero);
    bool isUp = offset.dy > 100;
    final bgColor = widget.bgColor ?? context.elTheme.tooltipColor;
    return UnconstrainedBox(
      child: CompositedTransformFollower(
        link: layerLink,
        targetAnchor: isUp ? Alignment.topCenter : Alignment.bottomCenter,
        followerAnchor: isUp ? Alignment.bottomCenter : Alignment.topCenter,
        child: Column(
          children: [
            if (!isUp)
              ElTriangle(
                direction: AxisDirection.up,
                color: bgColor,
              ),
            MouseRegion(
              onEnter: (e) {
                if (_delayRemove != null) {
                  _delayRemove!.cancel();
                  _delayRemove = null;
                }
              },
              onExit: (e) {
                _delayRemove = removeOverlay.delay(100);
              },
              child: buildContentWidget(bgColor),
            ),
            if (isUp)
              ElTriangle(
                direction: AxisDirection.down,
                color: bgColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget buildContentWidget(Color bgColor) {
    late Widget result;
    bool isTextWidget = true;
    if (DartUtil.isBaseType(widget.content)) {
      result = ElText(widget.content);
      if (widget.selected) {
        result = SelectionArea(child: result);
      }
    } else {
      result = widget.content;
      if (!(widget.content is ElTypographyInheritedWidget ||
          widget.content is Text ||
          widget.content is RichText)) {
        isTextWidget = false;
      }
    }
    result = Container(
      padding: isTextWidget
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
          : null,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(context.elConfig.radius),
      ),
      child: ElTypographyInheritedWidget(
        data: ElTypographyInheritedWidget.of(context).mergeText(
          TextStyle(
            color: bgColor.elTextColor(context),
            fontSize: 12,
          ),
        ),
        child: result,
      ),
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ElHover(
      onlyCursor: true,
      onEnter: (e) {
        insertOverlay();
      },
      onExit: (e) {
        _delayRemove = removeOverlay.delay(100);
      },
      builder: (isHover) => CompositedTransformTarget(
        link: layerLink,
        child: widget.child,
      ),
    );
  }
}
