part of flutter_element_ui;

class _FixedTableHeader extends StatelessWidget {
  const _FixedTableHeader({
    required this.columns,
    this.firstNoneBorder = false,
  });

  final List<ElTableColumn> columns;

  /// 第一列不要渲染左边框
  final bool firstNoneBorder;

  @override
  Widget build(BuildContext context) {
    var borderSide = BorderSide(color: ElAppData.of(context).currentTheme.defaultBorderColor);
    var rowHeight = _ElTableData.of(context).rowHeight;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: borderSide),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (firstNoneBorder)
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
          ...columns.sublist(firstNoneBorder ? 1 : 0).map(
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
