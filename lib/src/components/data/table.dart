part of flutter_element_ui;

class _ElTableData extends InheritedWidget {
  const _ElTableData({
    required super.child,
    required this.rowHeight,
    required this.tableMinWidth,
    required this.firstColumn,
    required this.otherColumn,
    required this.constraints,
  });

  final double rowHeight;
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
  }

  @override
  Widget build(BuildContext context) {
    Map<int, TableColumnWidth> columnWidths = {};
    for (int i = 0; i < widget.columns.length; i++) {
      if (widget.columns[i].width == null) {
        columnWidths[i] = const FlexColumnWidth();
      } else {
        columnWidths[i] = FixedColumnWidth(widget.columns[i].width!);
      }
    }
    ElTableColumn firstColumn = widget.columns[0];
    List<ElTableColumn> otherColumn = widget.columns.sublist(1);
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        border: Border.all(color: $defaultBorderColor),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        var tableWidget = Column(
          children: [
            const _TableHeader(),
            Expanded(
              child: _TableDataItem(
                data: widget.data,
                highlightCurrentRow: widget.highlightCurrentRow,
                scrollController: verticalScrollController,
                // verticalPosition: verticalPosition,
              ),
            ),
          ],
        );
        late Widget child = SizedBox(
          width: constraints.maxWidth,
          child: ScrollConfiguration(
            behavior: _TableScrollBehavior(),
            child: SingleChildScrollView(
              controller: horizontalScrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                width: constraints.maxWidth <= tableMinWidth ? tableMinWidth : constraints.maxWidth,
                child: tableWidget,
              ),
            ),
          ),
        );
        return _ElTableData(
          rowHeight: widget.rowHeight,
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

Widget _buildColumnWidthWidget({required Widget child, required ElTableColumn column}) {
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

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    var borderSide = BorderSide(color: ElAppData.of(context).currentTheme.defaultBorderColor);
    var rowHeight = _ElTableData.of(context).rowHeight;
    var firstColumn = _ElTableData.of(context).firstColumn;
    var otherColumn = _ElTableData.of(context).otherColumn;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: borderSide),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildColumnWidthWidget(
            child: SizedBox(
              height: rowHeight,
              child: Align(
                alignment: Alignment.center,
                child: Text(firstColumn.label ?? ""),
              ),
            ),
            column: firstColumn,
          ),
          ...otherColumn.map(
            (e) => _buildColumnWidthWidget(
              child: Container(
                height: rowHeight,
                decoration: BoxDecoration(
                  border: Border(left: borderSide),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(e.label ?? ''),
                ),
              ),
              column: e,
            ),
          ),
        ],
      ),
    );
  }
}

class _TableDataItem extends StatefulWidget {
  const _TableDataItem({
    required this.data,
    required this.highlightCurrentRow,
    required this.scrollController,
  });

  final List<Map> data;
  final bool highlightCurrentRow;
  final ScrollController scrollController;

  @override
  State<_TableDataItem> createState() => _TableDataItemState();
}

class _TableDataItemState extends State<_TableDataItem> with ElMouseMixin, ElThemeMixin {
  @override
  MouseCursor get cursor => MouseCursor.defer;

  @override
  Widget build(BuildContext context) {
    var rowHeight = _ElTableData.of(context).rowHeight;
    var firstColumn = _ElTableData.of(context).firstColumn;
    var otherColumn = _ElTableData.of(context).otherColumn;

    return SuperListView.builder(
      controller: widget.scrollController,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.data.length,
      itemBuilder: (context, index) => DecoratedBox(
        decoration: BoxDecoration(
          color: widget.highlightCurrentRow && onHover ? $bgColor.deepen(5) : null,
          border: Border(bottom: BorderSide(color: $defaultBorderColor)),
        ),
        child: Row(
          children: [
            _buildColumnWidthWidget(
              child: SizedBox(
                height: rowHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: buildContent(widget.data[index], firstColumn),
                ),
              ),
              column: firstColumn,
            ),
            ...otherColumn.map(
              (column) => _buildColumnWidthWidget(
                child: Container(
                  height: rowHeight,
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: $defaultBorderColor)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: buildContent(widget.data[index], column),
                  ),
                ),
                column: column,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContent(Map dataItem, ElTableColumn column) {
    if (column.render != null) {
      return column.render!(dataItem);
    } else if (column.prop != null) {
      return Text(
        ElUtil.safeString(dataItem[column.prop] ?? ''),
      );
    } else {
      return const SizedBox();
    }
  }
}

class _TableScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        assert(details.controller != null);
        return Scrollbar(
          controller: details.controller,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }
}
