part of flutter_element_ui;

class _TableBody extends StatelessWidget {
  const _TableBody({
    required this.data,
    required this.scrollController,
  });

  final List<Map> data;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SuperListView.builder(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) => _TableBodyItem(
        dataItem: data[index],
      ),
    );
  }
}

class _TableBodyItem extends StatefulWidget {
  const _TableBodyItem({required this.dataItem});

  final Map dataItem;

  @override
  State<_TableBodyItem> createState() => _TableBodyItemState();
}

class _TableBodyItemState extends State<_TableBodyItem> with ElMouseMixin, ElThemeMixin {
  @override
  MouseCursor get cursor => MouseCursor.defer;

  @override
  Widget build(BuildContext context) {
    var _elTableData = _ElTableData.of(context);
    var rowHeight = _elTableData.rowHeight;
    var firstColumn = _elTableData.firstColumn;
    var otherColumn = _elTableData.otherColumn;

    return buildMouseWidget(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _elTableData.highlightCurrentRow && onHover ? $bgColor.deepen(5) : null,
          border: Border(bottom: BorderSide(color: $defaultBorderColor)),
        ),
        child: Row(
          children: [
            _buildColumnItemWidget(
              child: SizedBox(
                height: rowHeight,
                child: Align(
                  alignment: Alignment.center,
                  child: _buildTableBodyItemContainer(widget.dataItem, firstColumn),
                ),
              ),
              column: firstColumn,
            ),
            ...otherColumn.map(
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
