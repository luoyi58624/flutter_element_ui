part of flutter_element_ui;

class _ElTableData extends InheritedWidget {
  const _ElTableData({
    required super.child,
    required this.rowHeight,
    required this.highlightCurrentRow,
    required this.tableMinWidth,
    required this.firstColumn,
    required this.otherColumn,
    required this.constraints,
  });

  final double rowHeight;
  final bool highlightCurrentRow;
  final double tableMinWidth;
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
  ScrollController horizontalScrollController = ScrollController();
  ScrollController verticalScrollController = ScrollController();
  ScrollController scrollController1 = ScrollController();
  ScrollController scrollController2 = ScrollController();
  ScrollController scrollController3 = ScrollController();

  List<ElTableColumn> autoColumn = [];
  List<ElTableColumn> fixedLeftColumn = [];
  List<ElTableColumn> fixedRightColumn = [];

  /// 表格最小宽度
  double get tableMinWidth {
    double width = 0;
    widget.columns.forEach((e) {
      if (e.width == null) {
        width += e.minWidth;
      } else {
        width += e.width!;
      }
    });
    return width;
  }

  @override
  void dispose() {
    super.dispose();
    horizontalScrollController.dispose();
    verticalScrollController.dispose();
    scrollController1.dispose();
    scrollController2.dispose();
    scrollController3.dispose();
  }

  void calcTableColumn() {
    autoColumn = [];
    fixedLeftColumn = [];
    fixedRightColumn = [];
    widget.columns.forEach((column) {
      if (column.fixedLeft) {
        fixedLeftColumn.add(column);
      } else if (column.fixedRight) {
        fixedRightColumn.add(column);
      } else {
        autoColumn.add(column);
      }
    });
  }

  Widget buildHorizontal({
    required Widget child,
    bool enable = true,
  }) {
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

  @override
  Widget build(BuildContext context) {
    ElTableColumn firstColumn = widget.columns[0];
    List<ElTableColumn> otherColumn = widget.columns.sublist(1);
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: $defaultBorderColor),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        ElLogger(constraints);
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
        Widget child = Row(
          children: [
            _TableColumnScroll(
              controller: scrollController1,
              linkageController: [scrollController2, scrollController3],
              child: Container(
                color: Colors.grey,
                child: Column(
                  children: List.generate(
                    widget.data.length,
                    (index) => SizedBox(
                      height: 50,
                      width: 200,
                      child: Text('item - ${index + 1}'),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: buildHorizontal(
                enable: true,
                child: _TableColumnScroll(
                  controller: scrollController2,
                  linkageController: [scrollController1, scrollController3],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.data.length,
                      (index) => SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            10,
                            (rowIndex) => Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              color: Colors.grey.shade300,
                              child: Text('item - ${index + 1} - ${rowIndex + 1}'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _TableColumnScroll(
              controller: scrollController3,
              linkageController: [scrollController1, scrollController2],
              enableScrollbar: true,
              child: Container(
                color: Colors.grey,
                child: Column(
                  children: List.generate(
                    widget.data.length,
                    (index) => SizedBox(
                      height: 50,
                      width: 200,
                      child: Text('item - ${index + 1}'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
        return _ElTableData(
          rowHeight: widget.rowHeight,
          highlightCurrentRow: widget.highlightCurrentRow,
          tableMinWidth: tableMinWidth,
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
