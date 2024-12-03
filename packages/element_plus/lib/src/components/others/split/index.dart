import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'theme.dart';

part '../../../generates/components/others/split/index.g.dart';

/// 分割器触发偏移位置
enum ElSplitPosition {
  /// 左偏移，如果是垂直分割布局，则上偏移
  left,

  /// 居中偏移
  center,

  /// 右偏移，如果是垂直分割布局，则下偏移
  right,
}

/// Element UI 拖拽分割器，它内部会通过 [Overlay] 创建可交互的拖拽器
class ElSplit extends StatefulWidget {
  const ElSplit({super.key});

  @override
  State<ElSplit> createState() => _ElSplitState();
}

class _ElSplitState extends State<ElSplit> {
  ElSplitThemeData? _themeData;

  ElSplitThemeData get themeData => _themeData!;

  set themeData(ElSplitThemeData value) {
    _themeData = value;
    removeOverlay();
    insertOverlay();
  }

  final size = Obs(Size.zero);
  final isActive = Obs(false);
  final LayerLink layerLink = LayerLink();
  OverlayState? overlayState;
  OverlayEntry? overlayEntry;

  void insertOverlay() {
    if (overlayEntry == null) {
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
              },
              onDragEnd: (e) {
                themeData.onEnd?.call();
                isActive.value = false;
                el.cursor.remove();
              },
              onHorizontalDragUpdate: !isVertical
                  ? null
                  : (e) {
                      themeData.onChanged?.call(e.delta.dx);
                    },
              onVerticalDragUpdate: isVertical
                  ? null
                  : (e) {
                      themeData.onChanged?.call(e.delta.dy);
                    },
              child: result,
            ),
          ),
        );
      });
      nextTick(() {
        overlayState!.insert(overlayEntry!);
      });
    }
  }

  void removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nextTick(() {
      if (mounted) {
        size.value = context.size!;
      }
    });

    overlayState ??= Overlay.of(context);
    themeData = ElSplitTheme.of(context);

    Widget result = themeData.axis == Axis.vertical
        ? SizedBox(width: themeData.size, height: double.infinity)
        : SizedBox(height: themeData.size, width: double.infinity);
    if (themeData.color != null) {
      result = ColoredBox(
        color: themeData.color!,
        child: result,
      );
    }
    return CompositedTransformTarget(
      link: layerLink,
      child: result,
    );
  }
}
