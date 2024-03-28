part of flutter_element_ui;

class _ElTableData extends InheritedWidget {
  const _ElTableData({
    required super.child,
    required this.rowHeight,
    required this.highlightCurrentRow,
    required this.firstColumn,
    required this.otherColumn,
    required this.constraints,
  });

  final double rowHeight;
  final bool highlightCurrentRow;
  final ElTableColumn firstColumn;
  final List<ElTableColumn> otherColumn;
  final BoxConstraints constraints;

  static _ElTableData of(BuildContext context) {
    final _ElTableData? result = context.dependOnInheritedWidgetOfExactType<_ElTableData>();
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
  });

  /// 表格数据
  final List<Map> data;

  /// 配置表格列
  final List<ElTableColumn> columns;

  /// 表格整体高度
  final double? height;

  /// 表格行高度
  final double rowHeight;

  /// 是否高亮当前行
  final bool highlightCurrentRow;

  @override
  State<ElTable> createState() => _ElTableState();
}

class _ElTableState extends State<ElTable> with ElThemeMixin {
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
    columns.forEach((e) {
      if (e.width == null) {
        width += e.minWidth;
      } else {
        width += e.width!;
      }
    });
    return width;
  }

  /// 获取没有固定列的最大宽度
  double getColumnMaxWidth(BoxConstraints constraints) {
    return constraints.maxWidth - fixedLeftColumnWidth - fixedRightColumnWidth;
  }

  @override
  void dispose() {
    super.dispose();
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
    widget.columns.forEach((e) {
      if (e.fixedLeft) {
        fixedLeftColumnList.add(e);
      } else if (e.fixedRight) {
        fixedRightColumnList.add(e);
      } else {
        columnList.add(e);
      }
    });

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
  Widget buildHorizontalScrollWidget({required Widget child, bool enable = true}) {
    return enable
        ? ScrollConfiguration(
            behavior: const _TableScrollBehavior(enableScrollbar: true),
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
        width: columnMaxWidth <= columnMinWidth ? columnMinWidth : columnMaxWidth,
        child: Column(
          children: [
            _FixedTableHeader(
              columns: columnList,
              firstNoneBorder: fixedLeftColumnList.isEmpty,
            ),
            Expanded(
              child: _TableColumnScroll(
                controller: scrollController,
                linkageController: [fixedLeftScrollController, fixedRightScrollController],
                enableScrollbar: fixedRightColumnList.isEmpty,
                itemCount: widget.data.length,
                itemBuilder: (context, index) => _TableRowItem(
                  dataItem: widget.data[index],
                  columns: columnList,
                  firstNoneBorder: fixedLeftColumnList.isEmpty,
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
        _FixedTableHeader(
          columns: fixedLeftColumnList,
          firstNoneBorder: true,
        ),
        Expanded(
          child: _TableColumnScroll(
            controller: fixedLeftScrollController!,
            linkageController: [scrollController, fixedRightScrollController],
            itemCount: widget.data.length,
            itemBuilder: (context, index) => _TableRowItem(
              dataItem: widget.data[index],
              columns: fixedLeftColumnList,
              firstNoneBorder: true,
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
        _FixedTableHeader(columns: fixedRightColumnList),
        Expanded(
          child: _TableColumnScroll(
            controller: fixedRightScrollController!,
            linkageController: [scrollController, fixedLeftScrollController],
            enableScrollbar: true,
            itemCount: widget.data.length,
            itemBuilder: (context, index) => _TableRowItem(
              dataItem: widget.data[index],
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
    ElTableColumn firstColumn = widget.columns[0];
    List<ElTableColumn> otherColumn = widget.columns.sublist(1);
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: $defaultBorderColor),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        // var tableWidget = Column(
        //   children: [
        //     const _TableHeader(),
        //     Expanded(
        //       child: _TableBody(
        //         data: widget.data,
        //         scrollController: verticalScrollController,
        //       ),
        //     ),
        //   ],
        // );
        // late Widget child = SizedBox(
        //   width: constraints.maxWidth,
        //   child: ScrollConfiguration(
        //     behavior: _TableScrollBehavior(),
        //     child: SingleChildScrollView(
        //       controller: horizontalScrollController,
        //       scrollDirection: Axis.horizontal,
        //       physics: const ClampingScrollPhysics(),
        //       child: SizedBox(
        //         width: constraints.maxWidth <= tableMinWidth ? tableMinWidth : constraints.maxWidth,
        //         child: tableWidget,
        //       ),
        //     ),
        //   ),
        // );
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
          firstColumn: firstColumn,
          otherColumn: otherColumn,
          constraints: constraints,
          child: child,
        );
      }),
    );
  }
}

/// 构建列的每一项
Widget _buildColumnItemWidget({required Widget child, required ElTableColumn column}) {
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
