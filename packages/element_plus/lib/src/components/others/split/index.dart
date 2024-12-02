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

/// 拖拽分割器
class ElSplit extends StatefulWidget {
  const ElSplit({
    super.key,
    this.axis = Axis.vertical,
    this.size,
    this.triggerSize,
    this.color,
    this.activeColor,
    this.position,
  });

  /// 分割器方向，默认垂直
  final Axis axis;

  /// 控件占据页面的空间
  final double? size;

  /// 可拖拽控件触发范围
  final double? triggerSize;

  /// 控件颜色，默认边框颜色
  final Color? color;

  /// 拖拽激活颜色，默认 null
  final Color? activeColor;

  /// 分割条触发位置，默认居中。
  ///
  /// 如果你设置了较大触发范围，可能会遮挡了页面中的滚动条，你可以设置此参数调整触发位置。
  final ElSplitPosition? position;

  @override
  State<ElSplit> createState() => _ElSplitState();
}

class _ElSplitState extends State<ElSplit> {
  late ElSplitThemeData themeData;
  OverlayState? overlayState;
  OverlayEntry? overlayEntry;

  @override
  void dispose() {
    overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    overlayState ??= Overlay.of(context);
    themeData = ElSplitTheme.of(context).copyWith(
      size: widget.size,
      triggerSize: widget.triggerSize,
      color: widget.color,
      activeColor: widget.activeColor,
      position: widget.position,
    );
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(builder: (context) {
        Widget result = widget.axis == Axis.vertical
            ? SizedBox(width: themeData.triggerSize, height: double.infinity)
            : SizedBox(height: themeData.triggerSize, width: double.infinity);
        if (themeData.activeColor != null) {
          result = ColoredBox(
            color: themeData.activeColor!,
            child: result,
          );
        }
        return UnconstrainedBox(
          child: ElEvent(
            child: result,
          ),
        );
      });
      nextTick(() {
        overlayState!.insert(overlayEntry!);
      });
    }

    Widget result = widget.axis == Axis.vertical
        ? SizedBox(width: themeData.size, height: double.infinity)
        : SizedBox(height: themeData.size, width: double.infinity);
    if (themeData.color != null) {
      result = ColoredBox(
        color: themeData.color!,
        child: result,
      );
    }
    return result;
  }
}
