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
  /// 分割条组件，它用于调整两个布局之间的尺寸，该小部件被设计为配置文件，它并不处理拖拽逻辑，
  /// 你可以继承它重写内部的方法实现统一风格的自定义分割条。
  const ElSplitResizer({
    super.key,
    this.size = 0,
    this.triggerSize = 8,
    this.position = ElSplitResizerPosition.center,
  })  : assert(size >= 0),
        assert(triggerSize >= 1);

  /// 控件占据页面的空间
  final double size;

  /// 可拖拽控件触发范围
  final double triggerSize;

  /// 分割条触发位置，默认居中。
  ///
  /// 如果你设置了较大触发范围，但可能会遮挡了左右部分空间，
  /// 你可以根据需求调整触发位置。
  final ElSplitResizerPosition position;

  @override
  Widget build(BuildContext context) {
    return ElSplitPanel.isRow(context)
        ? SizedBox(width: size, height: double.infinity)
        : SizedBox(height: size, width: double.infinity);
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
            child: isRow
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragStart: (e) {
                      $el.disabledHover.value = true;
                      $el.cursor.value = SystemMouseCursors.resizeColumn;
                      isActive.value = true;
                    },
                    onHorizontalDragUpdate: (e) {
                      if (isActive.value) updateFun(e.delta.dx);
                    },
                    onHorizontalDragEnd: (e) {
                      endFun();
                      $el.disabledHover.value = false;
                      $el.cursor.value = SystemMouseCursors.basic;
                      isActive.value = false;
                    },
                    onHorizontalDragCancel: () {
                      endFun();
                      $el.disabledHover.value = false;
                      $el.cursor.value = SystemMouseCursors.basic;
                      isActive.value = false;
                    },
                    child: const MouseRegion(
                      cursor: SystemMouseCursors.resizeColumn,
                    ),
                  )
                : GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onVerticalDragStart: (e) {
                      $el.disabledHover.value = true;
                      $el.cursor.value = SystemMouseCursors.resizeRow;
                      isActive.value = true;
                    },
                    onVerticalDragUpdate: (e) {
                      if (isActive.value) updateFun(e.delta.dy);
                    },
                    onVerticalDragEnd: (e) {
                      endFun();
                      $el.disabledHover.value = false;
                      $el.cursor.value = SystemMouseCursors.basic;
                      isActive.value = false;
                    },
                    onVerticalDragCancel: () {
                      endFun();
                      $el.disabledHover.value = false;
                      $el.cursor.value = SystemMouseCursors.basic;
                      isActive.value = false;
                    },
                    child: const MouseRegion(
                      cursor: SystemMouseCursors.resizeRow,
                    ),
                  ),
          ),
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
    final isRow = ElSplitPanel.isRow(context);
    return buildResizer(
      context,
      updateFun: (e) {
        data.reversal ? data.size.value -= e : data.size.value += e;
        if (data.size.value <= data.minSize) {
          $el.cursor.value = isRow
              ? SystemMouseCursors.resizeRight
              : SystemMouseCursors.resizeDown;
        } else if (data.maxSize != null && data.size.value >= data.maxSize!) {
          $el.cursor.value = isRow
              ? SystemMouseCursors.resizeLeft
              : SystemMouseCursors.resizeUp;
        } else {
          $el.cursor.value = isRow
              ? SystemMouseCursors.resizeColumn
              : SystemMouseCursors.resizeRow;
        }
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
