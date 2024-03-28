part of flutter_element_ui;

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.columns});

  final List<ElTableColumn> columns;

  @override
  Widget build(BuildContext context) {
    var borderSide = BorderSide(color: ElAppData.of(context).currentTheme.defaultBorderColor);
    var rowHeight = _ElTableData.of(context).rowHeight;
    var column = columns[0];
    late List<Widget> children;
    if (!column.fixedLeft && !column.fixedRight) {
      children = [
        _buildColumnItemWidget(
          child: SizedBox(
            height: rowHeight,
            child: Align(
              alignment: Alignment.center,
              child: Text(columns[0].label ?? ""),
            ),
          ),
          column: columns[0],
        ),
        ...columns.sublist(1).map(
              (e) => _buildColumnItemWidget(
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
      ];
    } else {
      var border = _buildColumnBroder(column, borderSide);
      children = columns
          .map((e) => _buildColumnItemWidget(
                child: Container(
                  height: rowHeight,
                  decoration: BoxDecoration(border: border),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(e.label ?? ''),
                  ),
                ),
                column: e,
              ))
          .toList();
    }
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: borderSide),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
