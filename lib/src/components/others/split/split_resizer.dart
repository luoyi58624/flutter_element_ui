part of 'split.dart';

/// 自定义构建分割条激活样式小部件
typedef ElSplitResizerActiveBuilder = Widget Function(
  BuildContext context,
  Obs<bool> isActive,
);

/// 分割条触发位置
enum ElSplitResizerTriggerPosition {
  left,
  center,
  right,
}

class ElSplitResizer extends ElSplitWidget {
  /// 分割条组件，它用于调整两个布局之间的尺寸，该小部件被设计为配置文件，它并不处理拖拽逻辑，
  /// 你可以继承它重写内部的方法实现统一风格的自定义分割条。
  const ElSplitResizer({
    super.key,
    this.size = 0,
    this.triggerSize = 8,
    this.activeSize = 4,
    this.activeColor,
    this.activeBuilder,
  })  : assert(size >= 0),
        assert(triggerSize >= 1),
        assert(activeSize >= 0 && activeSize <= triggerSize);

  /// 控件占据页面的空间
  final double size;

  /// 可拖拽控件触发范围
  final double triggerSize;

  /// 分割条激活大小，不能超过触发范围
  final double activeSize;

  /// 分割条激活颜色，默认为全局主题色
  final Color? activeColor;

  /// 自定义构建激活样式
  final ElSplitResizerActiveBuilder? activeBuilder;

  @override
  Widget build(BuildContext context) {
    return ElSplitPanel.isRow(context)
        ? SizedBox(width: size, height: double.infinity)
        : SizedBox(height: size, width: double.infinity);
  }

  /// 默认的激活样式分割条
  Widget activeWidget(BuildContext context, Obs<bool> isActive) {
    return ColoredBox(
      color: isActive.value
          ? (activeColor ?? context.elTheme.primary)
          : Colors.transparent,
    );
  }
}

typedef _UpdateFun = void Function(double value);

abstract class _ResizerWidget extends HookWidget {
  const _ResizerWidget(this.child);

  final ElSplitResizer child;

  Widget buildResizer(BuildContext context, _UpdateFun updateFun) {
    final isActive = useObs(false);
    final isRow = ElSplitPanel.isRow(context);
    final activeSize = child.activeSize;
    final triggerSize = child.triggerSize;
    final triggerOffsetSize = -((triggerSize / 2) + (child.size / 2));

    final activeWidget = Center(
      child: SizedBox(
        width: isRow ? activeSize : double.infinity,
        height: isRow ? double.infinity : activeSize,
        child: ObsBuilder(builder: (context) {
          if (child.activeBuilder == null) {
            return child.activeWidget(context, isActive);
          } else {
            return child.activeBuilder!(context, isActive);
          }
        }),
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: isRow ? 0 : triggerOffsetSize,
          bottom: isRow ? 0 : triggerOffsetSize,
          left: isRow ? triggerOffsetSize : 0,
          right: isRow ? triggerOffsetSize : 0,
          child: DeferPointer(
            child: isRow
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragStart: (e) {
                      isActive.value = true;
                    },
                    onHorizontalDragUpdate: (e) {
                      if (isActive.value) updateFun(e.delta.dx);
                    },
                    onHorizontalDragEnd: (e) {
                      isActive.value = false;
                    },
                    onHorizontalDragCancel: () {
                      isActive.value = false;
                    },
                    child: HoverBuilder(
                      cursor: SystemMouseCursors.resizeColumn,
                      builder: (isHover) => activeWidget,
                    ),
                  )
                : GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onVerticalDragStart: (e) {
                      isActive.value = true;
                    },
                    onVerticalDragUpdate: (e) {
                      if (isActive.value) updateFun(e.delta.dy);
                    },
                    onVerticalDragEnd: (e) {
                      isActive.value = false;
                    },
                    onVerticalDragCancel: () {
                      isActive.value = false;
                    },
                    child: HoverBuilder(
                      cursor: SystemMouseCursors.resizeRow,
                      builder: (isHover) => activeWidget,
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

    return buildResizer(context, (e) {
      data.reversal ? data.size.value -= e : data.size.value += e;
    });
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

    return buildResizer(context, (e) {
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
    });
  }
}
