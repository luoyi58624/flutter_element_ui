part of flutter_element_ui;

class _TableRowItem extends StatefulWidget {
  const _TableRowItem({
    required this.dataItem,
    required this.columns,
    this.firstNoneBorder = false,
  });

  final Map dataItem;
  final List<ElTableColumn> columns;

  /// 第一列不要渲染左边框
  final bool firstNoneBorder;

  @override
  State<_TableRowItem> createState() => _TableRowItemState();
}

class _TableRowItemState extends State<_TableRowItem> with ElMouseMixin, ElThemeMixin {
  @override
  MouseCursor get cursor => MouseCursor.defer;

  @override
  Widget build(BuildContext context) {
    var _elTableData = _ElTableData.of(context);
    var rowHeight = _elTableData.rowHeight;

    return buildMouseWidget(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _elTableData.highlightCurrentRow && onHover ? $bgColor.deepen(5) : null,
          border: Border(bottom: BorderSide(color: $defaultBorderColor)),
        ),
        child: Row(
          children: [
            if (widget.firstNoneBorder)
              _buildColumnItemWidget(
                child: SizedBox(
                  height: rowHeight,
                  child: Align(
                    alignment: Alignment.center,
                    child: _buildTableBodyItemContainer(widget.dataItem, widget.columns[0]),
                  ),
                ),
                column: widget.columns[0],
              ),
            ...widget.columns.sublist(widget.firstNoneBorder ? 1 : 0).map(
                  (column) => _buildColumnItemWidget(
                    child: Container(
                      height: rowHeight,
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: $defaultBorderColor)),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: _buildTableBodyItemContainer(widget.dataItem, column),
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
}

Widget _buildTableBodyItemContainer(Map dataItem, ElTableColumn column) {
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
