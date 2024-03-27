part of flutter_element_ui;

class ElTableColumn {
  /// 表格数据的key
  final String? prop;

  /// 表格列的标题
  final String? label;

  /// 表格列的宽度，这是一个固定宽度，若不指定则使用[minWidth]
  final double? width;

  /// 表格列的最小宽度，默认为50
  ///
  /// 当表格有剩余空间时，将会使用[Expanded]分配剩余空间，你可以设置[flex]参数定义当前列分配剩余空间的比例
  final double minWidth;

  /// [Expanded]的参数，默认为1
  final double flex;

  /// 自定义渲染
  final Widget Function(Map dataItem)? render;

  ElTableColumn({
    this.prop,
    this.label,
    this.width,
    this.minWidth = 50.0,
    this.flex = 1.0,
    this.render,
  });
}
