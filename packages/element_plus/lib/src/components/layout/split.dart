part of 'layout.dart';

/// 保存分割面板数据
abstract class _SplitLayoutData {
  /// 拖拽控件的偏移值，这是一个响应式变量，当发生更改时会自动重建绑定的相关组件
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
  final Obs<double> width;
  final double minWidth;
  final double maxWidth;

  _RowSplitLayoutData({
    required this.width,
    required this.minWidth,
    required this.maxWidth,
    required super.offset,
    required super.size,
    required super.triggerSize,
  });
}

/// 垂直布局分割数据
class _ColumnSplitLayoutData extends _SplitLayoutData {
  final Obs<double> height;
  final double minHeight;
  final double? maxHeight;

  _ColumnSplitLayoutData({
    required this.height,
    required this.minHeight,
    required this.maxHeight,
    required super.offset,
    required super.size,
    required super.triggerSize,
  });
}

/// 弹性布局分割数据
class _FlexSplitLayoutData extends _SplitLayoutData {
  final Obs<num> flex;
  final double minFlex;

  _FlexSplitLayoutData({
    required this.flex,
    required this.minFlex,
    required super.offset,
    required super.size,
    required super.triggerSize,
  });
}

class ElLayoutSplit extends ElLayoutWidget {
  /// Element UI 布局分割组件，它在两个布局中嵌入可拖拽控件，用于调整布局组件的尺寸大小，
  /// 作为 [ElLayout] 布局组件的一部分，它会自动计算如何处理两个布局之间的调整。
  ///
  ///
  /// 注意：由于 [ElLayout] 只接受 [ElLayoutWidget] 子类作为子组件，
  /// 所以如果你需要构建统一的公共拖拽组件，你需要继承它，然后覆写构造参数、重写构建方法即可，
  /// [ElLayoutSplit]只是一个配置类，实际拖拽逻辑由 [_SplitWidget] 处理。
  const ElLayoutSplit({
    super.key,
    this.size = 0,
    this.triggerSize = 6,
    this.builder,
  });

  /// 控件占据页面的空间
  final double size;

  /// 可拖拽控件触发范围
  final double triggerSize;

  /// 自定义构建拖拽控件
  final WidgetBuilder? builder;

  /// 构建分割组件样式，默认情况下它不包含任何样式，如果你想自定义任何外观，例如分割线，
  /// 请继承该组件并重写 build 方法即可，你可以构建任何你想要的分割样式组件。
  @override
  Widget build(BuildContext context) =>
      ElLayout.isRow(context) ? SizedBox(width: size) : SizedBox(height: size);
}

/// 分隔条的位置逻辑实现很丑陋，究其原因还是 Flutter 的定位系统有一个限制，
/// 对超出相对目标元素范围的元素事件系统无法命中，意思就是：Stack下有一个宽高为100的容器，
/// 我们堆叠了其他元素如果超出相对元素的范围，那么超出范围的部分事件系统无法命中。
class _SplitWidget extends HookWidget {
  const _SplitWidget({
    required this.layoutKey,
    required this.splitWidget,
  });

  final String layoutKey;
  final ElLayoutSplit splitWidget;

  @override
  Widget build(BuildContext context) {
    final $data = _ElLayoutInheritedWidget.of(context);
    return $data.isRow ? _buildRowSplit($data) : _buildColumnSplit($data);
  }

  Widget _buildRowSplit(_ElLayoutInheritedWidget data) {
    if (data.splitLayoutData![layoutKey]! is _FlexSplitLayoutData) {
      return _buildFlexRowSplit(data);
    }
    final splitData = data.splitLayoutData![layoutKey]! as _RowSplitLayoutData;
    final isStartDrag = useObs(false);
    return ObsBuilder(builder: (context) {
      return Positioned(
        top: 0,
        bottom: 0,
        // 计算水平布局垂直拖拽分隔条的位置，左侧布局组件offset + 宽度 - 分隔条中间偏移值
        left: max(
          splitData.offset.value +
              splitData.width.value -
              (splitData.triggerSize - splitData.size) / 2,
          splitData.minWidth,
        ),
        child: GestureDetector(
          onHorizontalDragStart: (e) {
            isStartDrag.value = true;
          },
          onHorizontalDragUpdate: (e) {
            if (isStartDrag.value) {
              splitData.width.value += e.delta.dx;
              data.notifyAllOffsetFun!(layoutKey);
            }
          },
          onHorizontalDragEnd: (e) {
            isStartDrag.value = false;
          },
          onHorizontalDragCancel: () {
            isStartDrag.value = false;
          },
          child: ElEvent(
            cursor: SystemMouseCursors.resizeColumn,
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

  Widget _buildColumnSplit(_ElLayoutInheritedWidget data) {
    final splitData =
        data.splitLayoutData![layoutKey]! as _ColumnSplitLayoutData;
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
          child: ElEvent(
            cursor: SystemMouseCursors.resizeRow,
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

  Widget _buildFlexRowSplit(_ElLayoutInheritedWidget data) {
    final splitData = data.splitLayoutData![layoutKey]! as _FlexSplitLayoutData;
    final isStartDrag = useObs(false);
    return ObsBuilder(builder: (context) {
      return Positioned(
        top: 0,
        bottom: 0,
        // 计算水平布局垂直拖拽分隔条的位置，左侧布局组件offset + 宽度 - 分隔条中间偏移值
        // left: max(
        //   splitData.offset.value +
        //       splitData.width.value -
        //       (splitData.triggerSize - splitData.size) / 2,
        //   splitData.minWidth,
        // ),
        child: GestureDetector(
          onHorizontalDragStart: (e) {
            isStartDrag.value = true;
          },
          // onHorizontalDragUpdate: (e) {
          //   if (isStartDrag.value) {
          //     splitData.width.value += e.delta.dx;
          //     data.notifyAllOffsetFun!(layoutKey);
          //   }
          // },
          onHorizontalDragEnd: (e) {
            isStartDrag.value = false;
          },
          onHorizontalDragCancel: () {
            isStartDrag.value = false;
          },
          child: ElEvent(
            cursor: SystemMouseCursors.resizeColumn,
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
