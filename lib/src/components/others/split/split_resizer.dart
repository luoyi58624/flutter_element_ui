part of 'split.dart';

/// 分割条触发偏移位置
enum ElSplitResizerPosition {
  /// 左偏移，如果是垂直分割布局，则上偏移
  left,

  /// 居中偏移
  center,

  /// 右偏移，如果是垂直分割布局，则下偏移
  right,
}

class ElSplitResizer extends ElSplitWidget {
  /// 分割条组件，它用于调整两个布局之间的尺寸，该小部件非常简单，它被定义为配置类，
  /// 实际拖拽逻辑由内部私有类实现。
  const ElSplitResizer({
    super.key,
    this.size = 0,
    this.color,
    this.triggerSize = 8,
    this.position = ElSplitResizerPosition.center,
  })  : assert(size >= 0),
        assert(triggerSize >= 1);

  /// 控件占据页面的空间
  final double size;

  /// 控件颜色
  final Color? color;

  /// 可拖拽控件触发范围
  final double triggerSize;

  /// 分割条触发位置，默认居中。
  ///
  /// 如果你设置了较大触发范围，可能会遮挡了页面中的滚动条，你可以设置此参数调整触发位置。
  final ElSplitResizerPosition position;

  /// 默认的分割条实现，它不会占据页面上的任何空间，你可以重写它实现任意风格的分隔条
  @override
  Widget build(BuildContext context) {
    Widget result = ElSplitPanel.isRow(context)
        ? SizedBox(width: size, height: double.infinity)
        : SizedBox(height: size, width: double.infinity);
    if (color != null) {
      result = ColoredBox(
        color: color!,
        child: result,
      );
    }
    return result;
  }
}

typedef _UpdateFun = void Function(double value);

abstract class _ResizerWidget extends HookWidget {
  const _ResizerWidget(this.child);

  final ElSplitResizer child;

  Widget buildResizer(
    BuildContext context, {
    required _UpdateFun updateFun,
    required VoidCallback endFun,
  }) {
    final isActive = useObs(false);
    final isRow = ElSplitPanel.isRow(context);
    var triggerOffsetSize = -(child.triggerSize / 2);

    late double top;
    late double bottom;
    late double left;
    late double right;

    if (isRow) {
      top = 0;
      bottom = 0;
      left = child.position == ElSplitResizerPosition.center
          ? triggerOffsetSize
          : child.position == ElSplitResizerPosition.left
              ? triggerOffsetSize * 2
              : 0;
      right = child.position == ElSplitResizerPosition.center
          ? triggerOffsetSize
          : child.position == ElSplitResizerPosition.left
              ? 0
              : triggerOffsetSize * 2;
    } else {
      left = 0;
      right = 0;
      top = child.position == ElSplitResizerPosition.center
          ? triggerOffsetSize
          : child.position == ElSplitResizerPosition.left
              ? triggerOffsetSize * 2
              : 0;
      bottom = child.position == ElSplitResizerPosition.center
          ? triggerOffsetSize
          : child.position == ElSplitResizerPosition.left
              ? 0
              : triggerOffsetSize * 2;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
          child: DeferPointer(
              paintOnTop: true,
              child: HoverBuilder(
                onlyCursor: true,
                cursor: isRow
                    ? SystemMouseCursors.resizeColumn
                    : SystemMouseCursors.resizeRow,
                builder: (context) => isRow
                    ? GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragStart: (e) {
                          el.setCursor(SystemMouseCursors.resizeColumn,
                              'drag_split_column');
                          isActive.value = true;
                        },
                        onHorizontalDragUpdate: (e) {
                          if (isActive.value) updateFun(e.delta.dx);
                        },
                        onHorizontalDragEnd: (e) {
                          endFun();
                          el.resetCursor('drag_split_column');
                          isActive.value = false;
                        },
                        onHorizontalDragCancel: () {
                          endFun();
                          el.resetCursor('drag_split_column');
                          isActive.value = false;
                        },
                      )
                    : GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onVerticalDragStart: (e) {
                          el.setCursor(
                              SystemMouseCursors.resizeRow, 'darg_split_row');
                          isActive.value = true;
                        },
                        onVerticalDragUpdate: (e) {
                          if (isActive.value) updateFun(e.delta.dy);
                        },
                        onVerticalDragEnd: (e) {
                          endFun();
                          el.resetCursor('darg_split_row');
                          isActive.value = false;
                        },
                        onVerticalDragCancel: () {
                          endFun();
                          el.resetCursor('darg_split_row');
                          isActive.value = false;
                        },
                      ),
              )),
        ),
      ],
    );
  }
}

/// 计算拖拽 SizedBox 分割面板
class _SizeResizerWidget extends _ResizerWidget {
  const _SizeResizerWidget(super.child, this.layoutId);

  final String layoutId;

  @override
  Widget build(BuildContext context) {
    final data = _SizedBoxSplitInheritedWidget.of(context).splitData[layoutId]!;
    return buildResizer(
      context,
      updateFun: (e) {
        data.reversal ? data.size.value -= e : data.size.value += e;
      },
      endFun: () {
        var size = data.size.value;
        size = max(size, data.minSize);
        if (data.maxSize != null) size = min(size, data.maxSize!);
        data.size.value = size;
      },
    );
  }
}

/// 计算拖拽 Flex 分割面板
class _FlexResizerWidget extends _ResizerWidget {
  const _FlexResizerWidget(super.child);

  @override
  Widget build(BuildContext context) {
    final isRow = ElSplitPanel.isRow(context);
    final data = _FlexSplitInheritedWidget.of(context);
    final (data1, data2) = data.splitData[hashCode]!;

    return buildResizer(
      context,
      updateFun: (e) {
        final sumFlex = data1.flex.value + data2.flex.value;
        var value = (e /
            (sumFlex /
                data.sumFlex *
                (isRow
                    ? ElSplitPanel.splitPanelContext(context).size!.width
                    : ElSplitPanel.splitPanelContext(context).size!.height)));
        final flexValue = (sumFlex * value).floor();
        data1.flex.value += flexValue;
        data2.flex.value -= flexValue;
      },
      endFun: () {},
    );
  }
}
