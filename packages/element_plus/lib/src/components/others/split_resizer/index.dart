import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'theme.dart';

part '../../../generates/components/others/split_resizer/index.g.dart';

/// 分割器交互偏移位置
enum ElSplitPosition {
  /// 左偏移，如果是垂直分割布局，则上偏移
  left,

  /// 居中偏移
  center,

  /// 右偏移，如果是垂直分割布局，则下偏移
  right,
}

/// Element UI 拖拽分割器，它内部会通过 [Overlay] 创建可交互的拖拽器，
/// 注意：[ElSplitResizer] 只负责提供拖拽交互，不会对交互数据做任何校验。
class ElSplitResizer extends StatefulWidget {
  const ElSplitResizer({super.key, this.onChanged, this.onStart, this.onEnd});

  /// 分割器拖拽偏移
  final ValueChanged<double>? onChanged;

  /// 分割器开始拖拽
  final VoidCallback? onStart;

  /// 分割器结束拖拽
  final VoidCallback? onEnd;

  @override
  State<ElSplitResizer> createState() => _ElSplitResizerState();
}

class _ElSplitResizerState extends State<ElSplitResizer> {
  late ElSplitResizerThemeData themeData;
  final LayerLink layerLink = LayerLink();
  late OverlayEntry overlayEntry;
  final size = Obs(Size.zero);
  final isActive = Obs(false);

  void insertOverlay() {
    overlayEntry = OverlayEntry(builder: (context) {
      bool isVertical = themeData.axis == Axis.vertical;
      Widget result = ObsBuilder(builder: (context) {
        Widget result = isVertical
            ? SizedBox(
                width: themeData.triggerSize,
                height: size.value.height,
              )
            : SizedBox(
                width: size.value.width,
                height: themeData.triggerSize,
              );
        if (isActive.value && themeData.activeColor != null) {
          result = ColoredBox(
            color: themeData.activeColor!,
            child: result,
          );
        }
        return result;
      });

      late final Offset offset;
      switch (themeData.position!) {
        case ElSplitPosition.left:
          offset = isVertical
              ? Offset(-themeData.triggerSize! + themeData.size!, 0)
              : Offset(0, -themeData.triggerSize! + themeData.size!);
        case ElSplitPosition.center:
          offset = isVertical
              ? Offset(-(themeData.triggerSize! - themeData.size!) / 2, 0)
              : Offset(0, -(themeData.triggerSize! - themeData.size!) / 2);
        case ElSplitPosition.right:
          offset = const Offset(0, 0);
      }

      return UnconstrainedBox(
        child: CompositedTransformFollower(
          link: layerLink,
          offset: offset,
          child: ElEvent(
            behavior: HitTestBehavior.opaque,
            cursor: isVertical
                ? SystemMouseCursors.resizeColumn
                : SystemMouseCursors.resizeRow,
            onTapDown: (e) {
              isActive.value = true;
              el.cursor.add(isVertical
                  ? SystemMouseCursors.resizeColumn
                  : SystemMouseCursors.resizeRow);
              widget.onStart?.call();
            },
            onDragEnd: (e) {
              isActive.value = false;
              el.cursor.remove();
              widget.onEnd?.call();
            },
            onHorizontalDragUpdate: !isVertical
                ? null
                : (e) {
                    widget.onChanged?.call(e.delta.dx);
                  },
            onVerticalDragUpdate: isVertical
                ? null
                : (e) {
                    widget.onChanged?.call(e.delta.dy);
                  },
            child: result,
          ),
        ),
      );
    });

    nextTick(() {
      Overlay.of(context, rootOverlay: themeData.rootOverlay!)
          .insert(overlayEntry);
    });
  }

  @override
  void initState() {
    super.initState();
    insertOverlay();
  }

  @override
  void dispose() {
    overlayEntry.remove();
    overlayEntry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeData = ElSplitResizerTheme.of(context);

    assert(themeData.triggerSize! > themeData.size!,
        'ElSplitResizer 配置的 triggerSize 必须大于 size');

    nextTick(() {
      if (mounted) {
        size.value = context.size!;
      }
    });

    Widget result = themeData.axis == Axis.vertical
        ? SizedBox(width: themeData.size, height: double.infinity)
        : SizedBox(height: themeData.size, width: double.infinity);
    if (themeData.size! > 0) {
      result = ColoredBox(
        color: themeData.color ?? context.elLayout.borderColor!,
        child: result,
      );
    }

    return CompositedTransformTarget(
      link: layerLink,
      child: result,
    );
  }
}
