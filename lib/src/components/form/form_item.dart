import 'package:flutter/widgets.dart';

class ElFormItem extends StatelessWidget {
  const ElFormItem({
    super.key,
    required this.child,
    this.label,
    this.prop,
    this.required = false,
  });

  final Widget child;

  /// 表单项标签
  final String? label;

  /// 表单数据key
  final String? prop;

  /// 表单项是否必填
  final bool required;

  /// 从当前上下文获取表单项数据
  static ElFormItemData of(BuildContext context) =>
      _ElFormItemInheritedWidget.of(context);

  @override
  Widget build(BuildContext context) {
    return _ElFormItemInheritedWidget(
      data: ElFormItemData(
        label: label,
        prop: prop,
        required: required,
      ),
      child: child,
    );
  }
}

class ElFormItemData {
  /// 表单项标签
  final String? label;

  /// 表单数据key
  final String? prop;

  /// 表单项是否必填
  final bool required;

  ElFormItemData({
    required this.label,
    required this.prop,
    required this.required,
  });
}

class _ElFormItemInheritedWidget extends InheritedWidget {
  const _ElFormItemInheritedWidget({
    required super.child,
    required this.data,
  });

  final ElFormItemData data;

  static ElFormItemData of(BuildContext context) {
    final _ElFormItemInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_ElFormItemInheritedWidget>();
    assert(result != null, 'No _ElFormItemInheritedWidget found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(_ElFormItemInheritedWidget oldWidget) => true;
}
