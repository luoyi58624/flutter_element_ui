part of 'table.dart';

class _TableRowItem extends StatefulWidget {
  const _TableRowItem({
    required this.dataItem,
    required this.index,
    required this.columns,
  });

  final Map dataItem;
  final int index;
  final List<ElTableColumn> columns;

  @override
  State<_TableRowItem> createState() => _TableRowItemState();
}

class _TableRowItemState extends State<_TableRowItem> {
  @override
  Widget build(BuildContext context) {
    var borderSide = BorderSide(color: context.elTheme.borderColor);
    var _elTableData = _ElTableData.of(context);
    var rowHeight = _elTableData.rowHeight;
    var column = widget.columns[0];
    late List<Widget> children;
    if (!column.fixedLeft && !column.fixedRight) {
      children = [
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
        ...widget.columns.sublist(1).map(
              (column) => _buildColumnItemWidget(
                child: Container(
                  height: rowHeight,
                  decoration: BoxDecoration(
                    border: Border(left: borderSide),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: _buildTableBodyItemContainer(widget.dataItem, column),
                  ),
                ),
                column: column,
              ),
            ),
      ];
    } else {
      var border = _buildColumnBroder(column, borderSide);
      children = widget.columns
          .map(
            (column) => _buildColumnItemWidget(
              child: Container(
                height: rowHeight,
                decoration: BoxDecoration(
                  border: border,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: _buildTableBodyItemContainer(widget.dataItem, column),
                ),
              ),
              column: column,
            ),
          )
          .toList();
    }

    return MouseRegion(
      onHover: (e) {
        setState(() {
          _ElTableData.of(context).hoverIndex.value = widget.index;
        });
      },
      onExit: (e) {
        setState(() {
          _ElTableData.of(context).hoverIndex.value = -1;
        });
      },
      cursor: MouseCursor.defer,
      child: ValueListenableBuilder(
        valueListenable: _ElTableData.of(context).hoverIndex,
        builder: (context, value, _) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color:
                  _elTableData.highlightCurrentRow && value == widget.index ? context.elTheme.bgColor.deepen(5) : null,
              border: Border(bottom: BorderSide(color: context.elTheme.borderColor)),
            ),
            child: Row(children: children),
          );
        },
      ),
    );
  }
}

Widget _buildTableBodyItemContainer(Map dataItem, ElTableColumn column) {
  if (column.render != null) {
    return column.render!(dataItem);
  } else if (column.prop != null) {
    return Text(
      DartUtil.safeString(dataItem[column.prop] ?? ''),
    );
  } else {
    return const SizedBox();
  }
}
