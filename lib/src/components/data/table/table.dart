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
              child: _TableBody(
                data: widget.data,
                scrollController: verticalScrollController,
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
