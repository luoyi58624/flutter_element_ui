part of 'layout.dart';

/// 保存分割布局数据
abstract class _SplitLayoutData {
  /// 当前布局的偏移值，这是一个响应式变量，当发生更改时会自动重建绑定的相关组件
  final Obs<double> offset;

  _SplitLayoutData({required this.offset});
}

/// 水平布局分割数据
class _RowSplitLayoutData extends _SplitLayoutData {
  final double? minWidth;
  final double? maxWidth;

  _RowSplitLayoutData({
    required this.minWidth,
    required this.maxWidth,
    required super.offset,
  });
}

/// 垂直布局分割数据
class _ColumnSplitLayoutData extends _SplitLayoutData {
  final double? minHeight;
  final double? maxHeight;

  _ColumnSplitLayoutData({
    required this.minHeight,
    required this.maxHeight,
    required super.offset,
  });
}

class ElSplit extends ElLayoutWidget {
  /// Element UI 分割布局组件，它可以在两个布局中嵌入可拖拽控件，调整布局组件的尺寸大小，
  /// 如果你需要构建自定义风格样式的拖拽控件，请继承它并覆写内部的配置、方法。
  const ElSplit({
    super.key,
    this.size = 0,
    this.triggerSize = 100,
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
    final triggerPosition = triggerSize / 2;
    return DeferredPointerHandler(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: $isColumn ? double.infinity : size,
            height: $isColumn ? size : double.infinity,
          ),
          Positioned(
            // left: $isColumn ? 0 : -triggerPosition,
            // right: $isColumn ? 0 : triggerPosition,
            // top: $isColumn ? -triggerPosition : 0,
            // bottom: $isColumn ? triggerPosition : 0,
            left: 0,
            right: -10,
            top: 0,
            bottom: 0,
            child: DeferPointer(
              child: GestureDetector(
                onTap: () {
                  i('dian');
                },
                child: HoverBuilder(
                  cursor: $isColumn
                      ? SystemMouseCursors.resizeRow
                      : SystemMouseCursors.resizeColumn,
                  builder: (isHover) => Container(
                    // width: $isColumn ? double.infinity : triggerSize,
                    // height: $isColumn ? triggerSize : double.infinity,
                    // width: 100,
                    height: 400,
                    color: context.elTheme.error,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplitWidget extends StatelessWidget {
  const _SplitWidget({
    required this.layoutKey,
    required this.splitWidget,
  });

  final String layoutKey;
  final ElSplit splitWidget;

  @override
  Widget build(BuildContext context) {
    final $data = _ElLayoutInheritedWidget.of(context);
    final $splitData = $data.splitLayoutData![layoutKey]!;
    return Positioned(
      top: 0,
      bottom: 0,
      left: $splitData.offset.value - (splitTriggerSize - splitSize) / 2,
      child: GestureDetector(
        onHorizontalDragStart: (e) {
          setState(() {
            isStartDrag = true;
          });
        },
        onHorizontalDragUpdate: (e) {
          if (isStartDrag) {
            i(e);
            setState(() {
              left += e.delta.dx;
            });
          }
        },
        onHorizontalDragEnd: (e) {
          setState(() {
            isStartDrag = false;
          });
        },
        onHorizontalDragCancel: () {
          setState(() {
            isStartDrag = false;
          });
        },
        child: HoverBuilder(
          cursor: SystemMouseCursors.resizeColumn,
          onlyCursor: true,
          builder: (context) {
            return Stack(
              children: [
                SizedBox(width: splitTriggerSize),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: isStartDrag ? 0 : (splitTriggerSize - splitSize) / 2,
                  right: isStartDrag ? 0 : (splitTriggerSize - splitSize) / 2,
                  top: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isStartDrag ? splitTriggerSize : splitSize,
                    decoration: BoxDecoration(
                      color: isStartDrag ? Colors.cyan : null,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
