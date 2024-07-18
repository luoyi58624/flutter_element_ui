import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:flutter_obs/flutter_obs.dart';
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
  final _showOverlay = Obs(false);

  /// 监听 build 函数的更新，同步构建 Overlay 组件
  final _buildCount = Obs(0);
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _contentKey = GlobalKey();
  Timer? _delayHideOverlay;
  Size? _contentSize;

  /// 当小部件被插入到树中时立马插入 Overlay 组件，而不是响应用户事件再进行插入、移除
  late final Widget _overlayWidget = ObsBuilder(
      watch: [_buildCount],
      builder: (_) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset offset = renderBox.localToGlobal(Offset.zero);
        bool isUp = offset.dy > 100;
        final bgColor = widget.bgColor ?? context.elTheme.tooltipColor;
        ElUtil.nextTick(() {
          _setContentSize();
          i(_contentSize, 'build');
        });
        return Offstage(
          offstage: !_showOverlay.value,
          child: UnconstrainedBox(
            child: CompositedTransformFollower(
              link: _layerLink,
              targetAnchor: isUp ? Alignment.topCenter : Alignment.bottomCenter,
              followerAnchor:
                  isUp ? Alignment.bottomCenter : Alignment.topCenter,
              child: Column(
                children: [
                  if (!isUp)
                    ElTriangle(direction: AxisDirection.up, color: bgColor),
                  MouseRegion(
                    onEnter: (e) {
                      if (_delayHideOverlay != null) {
                        _delayHideOverlay!.cancel();
                        _delayHideOverlay = null;
                      }
                    },
                    onExit: (e) {
                      _delayHideOverlay = _hideOverlay.delay(100);
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
    ElUtil.nextTick(() async {
      Overlay.of(context).insert(OverlayEntry(builder: (_) {
        return _overlayWidget;
      }));
    });
  }

  void _hideOverlay() {
    _showOverlay.value = false;
    _delayHideOverlay = null;
  }

  void _setContentSize() {
    final RenderBox contentBox =
        _contentKey.currentContext!.findRenderObject()! as RenderBox;
    _contentSize = contentBox.size;
  }

  Widget _buildContentWidget(Color bgColor) {
    late Widget result;
    bool isTextWidget = true;
    if (DartUtil.isBaseType(widget.content)) {
      result = ElText(widget.content);
    } else {
      result = widget.content;
      if (!(widget.content is ElTypographyInheritedWidget ||
          widget.content is Text ||
          widget.content is RichText)) {
        isTextWidget = false;
      }
    }
    result = Container(
      key: _contentKey,
      padding: isTextWidget
          ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
          : null,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: context.elConfig.radius,
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
    if (widget.selected) result = SelectionArea(child: result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    ElUtil.nextTick(() {
      _buildCount.value++;
    });
    return ElHover(
      onlyCursor: true,
      onEnter: (e) {
        if (_delayHideOverlay == null) {
          _showOverlay.value = true;
        } else {
          _delayHideOverlay!.cancel();
          _delayHideOverlay = null;
        }
      },
      onExit: (e) {
        _delayHideOverlay = _hideOverlay.delay(100);
      },
      builder: (isHover) => CompositedTransformTarget(
        link: _layerLink,
        child: widget.child,
      ),
    );
  }
}
