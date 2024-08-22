import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../basic/text.dart';

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
  final showOverlay = Obs(false);

  /// 监听 build 函数的更新，同步构建 Overlay 组件
  final buildCount = Obs(0);
  final LayerLink layerLink = LayerLink();
  final GlobalKey contentKey = GlobalKey();
  late final OverlayEntry overlayEntry;
  Timer? delayHideOverlay;
  Size? contentSize;

  Color get bgColor => widget.bgColor ?? context.elTheme.tooltipColor;

  /// 将 Overlay 组件永久插入小部件树中，这样做可以保留内部状态
  late final Widget _overlayWidget = ObsBuilder(
      watch: [buildCount],
      builder: (_) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset offset = renderBox.localToGlobal(Offset.zero);
        bool isUp = offset.dy > 100;
        FlutterUtil.nextTick(() {
          _setContentSize();
          // i(_contentSize, 'build');
        });
        return Offstage(
          offstage: !showOverlay.value,
          child: UnconstrainedBox(
            child: CompositedTransformFollower(
              link: layerLink,
              targetAnchor: isUp ? Alignment.topCenter : Alignment.bottomCenter,
              followerAnchor:
                  isUp ? Alignment.bottomCenter : Alignment.topCenter,
              child: Column(
                children: [
                  if (!isUp)
                    ElTriangle(direction: AxisDirection.up, color: bgColor),
                  MouseRegion(
                    onEnter: (e) {
                      if (delayHideOverlay != null) {
                        delayHideOverlay!.cancel();
                        delayHideOverlay = null;
                      }
                    },
                    onExit: (e) {
                      delayHideOverlay = _hideOverlay.delay(100);
                    },
                    child: _buildContentWidget(bgColor),
                  ),
                  if (isUp)
                    ElTriangle(direction: AxisDirection.down, color: bgColor),
                ],
              ),
            ),
          ),
        );
      });

  @override
  void initState() {
    super.initState();
    FlutterUtil.nextTick(() async {
      overlayEntry = OverlayEntry(builder: (_) {
        return _overlayWidget;
      });
      Overlay.of(context, rootOverlay: true).insert(overlayEntry);
    });
  }

  @override
  void dispose() {
    super.dispose();
    overlayEntry.remove();
  }

  void _hideOverlay() {
    showOverlay.value = false;
    delayHideOverlay = null;
  }

  void _setContentSize() {
    final RenderBox contentBox =
        contentKey.currentContext!.findRenderObject()! as RenderBox;
    contentSize = contentBox.size;
  }

  Widget _buildContentWidget(Color bgColor) {
    late Widget result;
    bool isTextWidget = true;
    if (DartUtil.isBaseType(widget.content)) {
      result = ElText(
        widget.content,
        strutStyle: const StrutStyle(
          forceStrutHeight: true,
        ),
      );
    } else {
      result = widget.content;
      if (!(widget.content is ElText ||
          widget.content is Text ||
          widget.content is RichText)) {
        isTextWidget = false;
      }
    }
    result = Container(
      key: contentKey,
      padding: isTextWidget ? const EdgeInsets.fromLTRB(12, 6, 12, 8) : null,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: el.config.radius,
      ),
      child: ElDefaultTextStyle.merge(
        style: TextStyle(
          color: bgColor.elTextColor(context),
          fontSize: 12,
        ),
        child: result,
      ),
    );
    if (widget.selected) result = SelectionArea(child: result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    FlutterUtil.nextTick(() {
      buildCount.value++;
    });
    return HoverBuilder(
      onlyCursor: true,
      onEnter: (e) {
        if (delayHideOverlay == null) {
          showOverlay.value = true;
        } else {
          delayHideOverlay!.cancel();
          delayHideOverlay = null;
        }
      },
      onExit: (e) {
        delayHideOverlay = _hideOverlay.delay(100);
      },
      builder: (context) => CompositedTransformTarget(
        link: layerLink,
        child: widget.child,
      ),
    );
  }
}
