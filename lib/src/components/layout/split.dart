part of 'layout.dart';

/// 保存分割布局数据
abstract class _SplitLayoutData {
  /// 当前布局的偏移值，这是一个响应式变量，当发生更改时会自动重建绑定的相关组件
  final Obs<double> offset;

  /// 控件本身占据的空间
  final double size;

  /// 可拖拽控件触发范围
  final double triggerSize;

  _SplitLayoutData({
    required this.offset,
    required this.size,
    required this.triggerSize,
  });
}

/// 水平布局分割数据
class _RowSplitLayoutData extends _SplitLayoutData {
  final double minWidth;
  final double? maxWidth;

  _RowSplitLayoutData({
    required this.minWidth,
    required this.maxWidth,
    required super.offset,
    required super.size,
    required super.triggerSize,
  });
}

/// 垂直布局分割数据
class _ColumnSplitLayoutData extends _SplitLayoutData {
  final double minHeight;
  final double? maxHeight;

  _ColumnSplitLayoutData({
    required this.minHeight,
    required this.maxHeight,
    required super.offset,
    required super.size,
    required super.triggerSize,
  });
}

class ElSplit extends ElLayoutWidget {
  /// Element UI 分割布局组件，它可以在两个布局中嵌入可拖拽控件，调整布局组件的尺寸大小，
  /// 如果你需要构建自定义风格样式的拖拽控件，请继承它并覆写内部的配置、方法。
  const ElSplit({
    super.key,
    this.size = 0,
    this.triggerSize = 4,
    this.builder,
  });

  /// 控件本身占据的空间，默认0
  final double size;

  /// 可拖拽控件触发范围，默认10
  final double triggerSize;

  /// 自定义构建拖拽控件
  final WidgetBuilder? builder;

  @override
  Widget build(BuildContext context) {
    final $data = _ElLayoutInheritedWidget.of(context);
    final $isColumn = $data.isColumn;
    return SizedBox(
      width: $isColumn ? double.infinity : size,
      height: $isColumn ? size : double.infinity,
    );
  }
}

class _SplitWidget extends HookWidget {
  const _SplitWidget({
    required this.layoutKey,
    required this.splitWidget,
  });

  final String layoutKey;
  final ElSplit splitWidget;

  @override
  Widget build(BuildContext context) {
    final $data = _ElLayoutInheritedWidget.of(context);
    return $data.isColumn
        ? _buildColumnSplit(
            $data.splitLayoutData![layoutKey]! as _ColumnSplitLayoutData)
        : _buildRowSplit(
            $data.splitLayoutData![layoutKey]! as _RowSplitLayoutData);
  }

  Widget _buildColumnSplit(_ColumnSplitLayoutData splitData) {
    final isStartDrag = useObs(false);
    return ObsBuilder(builder: (context) {
      return Positioned(
        top: max(
          splitData.offset.value - (splitData.triggerSize - splitData.size) / 2,
          splitData.minHeight,
        ),
        left: 0,
        right: 0,
        child: GestureDetector(
          onVerticalDragStart: (e) {
            isStartDrag.value = true;
          },
          onVerticalDragUpdate: (e) {
            if (isStartDrag.value) splitData.offset.value += e.delta.dy;
          },
          onVerticalDragEnd: (e) {
            isStartDrag.value = false;
          },
          onVerticalDragCancel: () {
            isStartDrag.value = false;
          },
          child: HoverBuilder(
            cursor: SystemMouseCursors.resizeRow,
            onlyCursor: true,
            builder: (context) {
              return Stack(
                children: [
                  SizedBox(height: splitData.triggerSize),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    left: 0,
                    right: 0,
                    top: isStartDrag.value
                        ? 0
                        : (splitData.triggerSize - splitData.size) / 2,
                    bottom: isStartDrag.value
                        ? 0
                        : (splitData.triggerSize - splitData.size) / 2,
                    child: ObsBuilder(builder: (context) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: isStartDrag.value
                            ? splitData.triggerSize
                            : splitData.size,
                        decoration: BoxDecoration(
                          color: isStartDrag.value ? Colors.cyan : null,
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildRowSplit(_RowSplitLayoutData splitData) {
    final isStartDrag = useObs(false);
    return ObsBuilder(builder: (context) {
      return Positioned(
        top: 0,
        bottom: 0,
        left: max(
          splitData.offset.value - (splitData.triggerSize - splitData.size) / 2,
          splitData.minWidth,
        ),
        child: GestureDetector(
          onHorizontalDragStart: (e) {
            isStartDrag.value = true;
          },
          onHorizontalDragUpdate: (e) {
            if (isStartDrag.value) splitData.offset.value += e.delta.dx;
          },
          onHorizontalDragEnd: (e) {
            isStartDrag.value = false;
          },
          onHorizontalDragCancel: () {
            isStartDrag.value = false;
          },
          child: HoverBuilder(
            cursor: SystemMouseCursors.resizeColumn,
            onlyCursor: true,
            builder: (context) {
              return Stack(
                children: [
                  SizedBox(width: splitData.triggerSize),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    left: isStartDrag.value
                        ? 0
                        : (splitData.triggerSize - splitData.size) / 2,
                    right: isStartDrag.value
                        ? 0
                        : (splitData.triggerSize - splitData.size) / 2,
                    top: 0,
                    bottom: 0,
                    child: ObsBuilder(builder: (context) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isStartDrag.value
                            ? splitData.triggerSize
                            : splitData.size,
                        decoration: BoxDecoration(
                          color: isStartDrag.value ? Colors.cyan : null,
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
