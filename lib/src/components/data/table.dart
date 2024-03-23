part of flutter_element_ui;

class ElTable extends StatefulWidget {
  const ElTable({
    super.key,
    required this.data,
    required this.columns,
    this.height,
    this.rowHeight = 50,
  });

  /// 表格数据
  final List<Map<String, dynamic>> data;

  /// 配置表格列
  final List<ElTableColumn> columns;

  /// 表格整体高度
  final double? height;

  /// 表格行高度
  final double rowHeight;

  @override
  State<ElTable> createState() => _ElTableState();
}

class _ElTableState extends State<ElTable> with ElThemeMixin {
  ScrollController scrollController = ScrollController();

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
      child: Column(
        children: [
          _TableHeader(
            rowHeight: widget.rowHeight,
            firstColumn: firstColumn,
            otherColumn: otherColumn,
          ),
          Expanded(
            child: SuperListView.builder(
              controller: scrollController,
              itemCount: widget.data.length,
              itemBuilder: (context, index) => _TableDataItem(
                dataItem: widget.data[index],
                rowHeight: widget.rowHeight,
                firstColumn: firstColumn,
                otherColumn: otherColumn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildColumnWidthWidget({required Widget child, double? width}) {
  if (width == null) {
    return Expanded(child: child);
  } else {
    return SizedBox(width: width, child: child);
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({
    required this.rowHeight,
    required this.firstColumn,
    required this.otherColumn,
  });

  final double? rowHeight;
  final ElTableColumn firstColumn;
  final List<ElTableColumn> otherColumn;

  @override
  Widget build(BuildContext context) {
    var borderSide = BorderSide(color: ElAppData.of(context).currentTheme.defaultBorderColor);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: borderSide),
      ),
      child: Row(
        children: [
          _buildColumnWidthWidget(
              child: SizedBox(
                height: rowHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(firstColumn.label),
                ),
              ),
              width: firstColumn.width),
          ...otherColumn.map(
            (e) => _buildColumnWidthWidget(
              child: Container(
                height: rowHeight,
                decoration: BoxDecoration(
                  border: Border(left: borderSide),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(e.label),
                ),
              ),
              width: e.width,
            ),
          ),
        ],
      ),
    );
  }
}

class _TableDataItem extends StatefulWidget {
  const _TableDataItem({
    required this.dataItem,
    required this.rowHeight,
    required this.firstColumn,
    required this.otherColumn,
  });

  final Map<String, dynamic> dataItem;
  final double? rowHeight;
  final ElTableColumn firstColumn;
  final List<ElTableColumn> otherColumn;

  @override
  State<_TableDataItem> createState() => _TableDataItemState();
}

class _TableDataItemState extends State<_TableDataItem> with ElMouseMixin, ElThemeMixin {
  @override
  MouseCursor get cursor => MouseCursor.defer;

  @override
  Widget build(BuildContext context) {
    return buildMouseWidget(
      child: Container(
        decoration: BoxDecoration(
          color: onHover ? $bgColor.deepen(5) : null,
          border: Border(bottom: BorderSide(color: $defaultBorderColor)),
        ),
        child: Row(
          children: [
            _buildColumnWidthWidget(
              child: SizedBox(
                height: widget.rowHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    ElUtil.safeString(widget.dataItem[widget.firstColumn.prop]),
                  ),
                ),
              ),
              width: widget.firstColumn.width,
            ),
            ...widget.otherColumn.map(
              (column) => _buildColumnWidthWidget(
                child: Container(
                  height: widget.rowHeight,
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: $defaultBorderColor)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      ElUtil.safeString(widget.dataItem[column.prop]),
                    ),
                  ),
                ),
                width: column.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
