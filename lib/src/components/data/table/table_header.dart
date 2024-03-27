part of flutter_element_ui;

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
          _buildColumnItemWidget(
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
        ],
      ),
    );
  }
}
