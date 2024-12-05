import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';

import 'config.dart';

part 'table_header.dart';

part 'table_row_item.dart';

part 'table_scroll.dart';

class _ElTableData extends InheritedWidget {
  const _ElTableData({
    required super.child,
    required this.rowHeight,
    required this.highlightCurrentRow,
    required this.constraints,
    required this.hoverIndex,
  });

  final double rowHeight;
  final bool highlightCurrentRow;
  final BoxConstraints constraints;
  final ValueNotifier<int> hoverIndex;

  static _ElTableData of(BuildContext context) {
    final _ElTableData? result =
        context.dependOnInheritedWidgetOfExactType<_ElTableData>();
    assert(result != null, 'No _ElTableData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ElTableData oldWidget) {
    return true;
  }
}

class ElTable extends StatefulWidget {
  const ElTable({
    super.key,
    required this.data,
    required this.columns,
    this.height,
    this.rowHeight = 50,
    this.highlightCurrentRow = false,
    this.dragScroll = false,
  });

  /// 表格数据
  final List<Map> data;

  /// 配置表格列
  final List<ElTableColumn> columns;

  /// 表格整体高度
  final double? height;

  /// 表格行高度
  final double rowHeight;

  /// 是否高亮当前行，默认为false
  final bool highlightCurrentRow;

  /// 是否允许鼠标拖拽滚动，默认为false
  final bool dragScroll;

  @override
  State<ElTable> createState() => _ElTableState();
}

class _ElTableState extends State<ElTable> {
  final ValueNotifier<int> hoverIndex = ValueNotifier<int>(-1);

  /// 垂直滚动控制器
  ScrollController scrollController = ScrollController();

  /// 横向滚动控制器
  ScrollController horizontalScrollController = ScrollController();

  /// 固定在左边列的垂直滚动控制器
  ScrollController? fixedLeftScrollController;

  /// 固定在右边列的垂直滚动控制器
  ScrollController? fixedRightScrollController;

  /// 没有设置固定列的列集合
  List<ElTableColumn> columnList = [];

  /// 设置固定在左边的列集合
  List<ElTableColumn> fixedLeftColumnList = [];

  /// 设置固定在右边的列集合
  List<ElTableColumn> fixedRightColumnList = [];

  /// 没有固定列的最小总宽度
  double columnMinWidth = 0.0;

  /// 固定在左边列的总宽度
  double fixedLeftColumnWidth = 0.0;

  /// 固定在右边列的总宽度
  double fixedRightColumnWidth = 0.0;

  /// 获取表格的总宽度
  double getColumnSumWidth(List<ElTableColumn> columns) {
    double width = 0;
    for (var e in columns) {
      if (e.width == null) {
        width += e.minWidth;
      } else {
        width += e.width!;
      }
    }
    return width;
  }

  /// 获取没有固定列的最大宽度
  double getColumnMaxWidth(BoxConstraints constraints) {
    return constraints.maxWidth - fixedLeftColumnWidth - fixedRightColumnWidth;
  }

  @override
  void dispose() {
    super.dispose();
    hoverIndex.dispose();
    scrollController.dispose();
    horizontalScrollController.dispose();
    fixedLeftScrollController?.dispose();
    fixedRightScrollController?.dispose();
  }

  /// 计算表格列，进行区域划分
  void calcTableColumn() {
    columnMinWidth = 0;
    fixedLeftColumnWidth = 0;
    fixedRightColumnWidth = 0;
    columnList = [];
    fixedLeftColumnList = [];
    fixedRightColumnList = [];
    for (var e in widget.columns) {
      if (e.fixedLeft) {
        fixedLeftColumnList.add(e);
      } else if (e.fixedRight) {
        fixedRightColumnList.add(e);
      } else {
        columnList.add(e);
      }
    }

    columnMinWidth = getColumnSumWidth(columnList);

    if (fixedLeftColumnList.isNotEmpty) {
      fixedLeftScrollController ??= ScrollController();
      fixedLeftColumnWidth = getColumnSumWidth(fixedLeftColumnList);
    } else {
      fixedLeftScrollController?.dispose();
      fixedLeftScrollController = null;
    }

    if (fixedRightColumnList.isNotEmpty) {
      fixedRightScrollController ??= ScrollController();
      fixedRightColumnWidth = getColumnSumWidth(fixedRightColumnList);
    } else {
      fixedRightScrollController?.dispose();
      fixedRightScrollController = null;
    }
  }

  /// 构建水平横向滚动容器组件
  Widget buildHorizontalScrollWidget(
      {required Widget child, bool enable = true}) {
    return enable
        ? ScrollConfiguration(
            key: ValueKey(widget.dragScroll),
            behavior: _TableScrollBehavior(
              enableScrollbar: true,
              dragScroll: widget.dragScroll,
            ),
            child: Scrollbar(
              controller: horizontalScrollController,
              child: SingleChildScrollView(
                controller: horizontalScrollController,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                child: child,
              ),
            ),
          )
        : child;
  }

  /// 构建未设置固定列的列组件
  Widget buildColumnWidget(double columnMaxWidth) {
    return buildHorizontalScrollWidget(
      enable: true,
      child: SizedBox(
        width:
            columnMaxWidth <= columnMinWidth ? columnMinWidth : columnMaxWidth,
        child: Column(
          children: [
            _TableHeader(columns: columnList),
            Expanded(
              child: _TableColumnScroll(
                controller: scrollController,
                linkageController: [
                  fixedLeftScrollController,
                  fixedRightScrollController
                ],
                enableScrollbar: fixedRightColumnList.isEmpty,
                dragScroll: widget.dragScroll,
                itemCount: widget.data.length,
                itemBuilder: (context, index) => _TableRowItem(
                  dataItem: widget.data[index],
                  index: index,
                  columns: columnList,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建固定在左边的列组件
  Widget buildFixedLeftColumnWidget() {
    return Column(
      children: [
        _TableHeader(columns: fixedLeftColumnList),
        Expanded(
          child: _TableColumnScroll(
            controller: fixedLeftScrollController!,
            linkageController: [scrollController, fixedRightScrollController],
            dragScroll: widget.dragScroll,
            itemCount: widget.data.length,
            itemBuilder: (context, index) => _TableRowItem(
              dataItem: widget.data[index],
              index: index,
              columns: fixedLeftColumnList,
            ),
          ),
        ),
      ],
    );
  }

  /// 构建固定在右边的列组件
  Widget buildFixedRightColumnWidget() {
    return Column(
      children: [
        _TableHeader(columns: fixedRightColumnList),
        Expanded(
          child: _TableColumnScroll(
            controller: fixedRightScrollController!,
            linkageController: [scrollController, fixedLeftScrollController],
            enableScrollbar: true,
            dragScroll: widget.dragScroll,
            itemCount: widget.data.length,
            itemBuilder: (context, index) => _TableRowItem(
              dataItem: widget.data[index],
              index: index,
              columns: fixedRightColumnList,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    calcTableColumn();
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: context.elLayout.borderColor!),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        var columnMaxWidth = getColumnMaxWidth(constraints);
        Widget child = Row(
          children: [
            if (fixedLeftColumnList.isNotEmpty)
              SizedBox(
                width: fixedLeftColumnWidth,
                height: constraints.maxHeight,
                child: buildFixedLeftColumnWidget(),
              ),
            Expanded(
              child: SizedBox(
                height: constraints.maxHeight,
                child: buildColumnWidget(columnMaxWidth),
              ),
            ),
            if (fixedRightColumnList.isNotEmpty)
              SizedBox(
                width: fixedRightColumnWidth,
                height: constraints.maxHeight,
                child: buildFixedRightColumnWidget(),
              ),
          ],
        );
        return _ElTableData(
          rowHeight: widget.rowHeight,
          highlightCurrentRow: widget.highlightCurrentRow,
          constraints: constraints,
          hoverIndex: hoverIndex,
          child: child,
        );
      }),
    );
  }
}

/// 构建列的每一项
Widget _buildColumnItemWidget(
    {required Widget child, required ElTableColumn column}) {
  if (column.width != null) {
    return SizedBox(width: column.width, child: child);
  } else {
    return Expanded(
      child: SizedBox(
        width: column.minWidth,
        child: child,
      ),
    );
  }
}

Border _buildColumnBroder(ElTableColumn column, BorderSide borderSide) {
  bool isFixedLeft = column.fixedLeft;
  return Border(
    left: isFixedLeft ? BorderSide.none : borderSide,
    right: isFixedLeft ? borderSide : BorderSide.none,
  );
}
