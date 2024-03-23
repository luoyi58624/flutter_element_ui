part of flutter_element_ui;

class ElTableColumn {
  /// 表格数据的key
  final String prop;

  /// 表格列的标题
  final String label;

  /// 表格列的宽度
  final double? width;

  ElTableColumn({
    required this.prop,
    required this.label,
    this.width,
  });
}
