import 'package:flutter/widgets.dart';

class ElFormItem extends StatelessWidget {
  const ElFormItem({
    super.key,
    this.label,
    this.prop,
  });

  /// 表单项标签
  final String? label;

  /// 表单数据key
  final String? prop;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
