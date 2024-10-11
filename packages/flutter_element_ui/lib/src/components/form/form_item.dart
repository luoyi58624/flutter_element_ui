import 'package:flutter_element_ui/flutter_element_ui.dart';

import '../../global.dart';

class ElFormItem extends StatelessWidget {
  const ElFormItem({
    super.key,
    required this.child,
    this.label,
    this.prop,
    this.required = false,
    this.labelWidth,
    this.labelPosition,
    this.labelAlign,
  });

  /// 指定任意子组件，如果内部包含 Element UI 表单体系组件，它们会通过[InheritedWidget]
  /// 访问父级默认配置
  final Widget child;

  /// 表单项标签
  final String? label;

  /// 表单数据key
  final String? prop;

  /// 表单项是否必填
  final bool required;

  /// 指定当前表单项的[label]宽度
  final double? labelWidth;

  /// 指定当前表单项的[label]位置
  final ElFormLabelPosition? labelPosition;

  /// 指定当前表单项的[label]对齐方式
  final ElFormLabelAlign? labelAlign;

  /// 从当前上下文获取表单项数据
  static ElFormItemData? of(BuildContext context) =>
      _ElFormItemInheritedWidget.of(context);

  @override
  Widget build(BuildContext context) {
    final formData = ElForm.of(context);
    assert(formData != null, 'ElFormItem 必须包裹在 ElForm 里面');
    final data = ElFormItemData(
      label: label,
      prop: prop,
      required: required,
      labelWidth: labelWidth ?? formData!.labelWidth,
      labelPosition: labelPosition ?? formData!.labelPosition,
      labelAlign: labelAlign ?? formData!.labelAlign,
    );
    return _ElFormItemInheritedWidget(
      data: data,
      child: buildLabelPosition(data, child),
    );
  }

  /// 构建标签
  Widget buildLabel(ElFormItemData data) {
    return SizedBox(
      width: data.labelWidth,
      child: data.label != null
          ? ElText(
              data.label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
    );
  }

  Widget buildLabelPosition(ElFormItemData data, Widget child) {
    final Widget childWidget = Expanded(child: child);
    return data.labelPosition == ElFormLabelPosition.left
        ? Row(
            children: [
              buildLabel(data),
              childWidget,
            ],
          )
        : Column(
            children: [
              buildLabel(data),
              childWidget,
            ],
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

  /// 指定当前表单项的[label]宽度
  final double? labelWidth;

  /// 指定当前表单项的[label]位置
  final ElFormLabelPosition labelPosition;

  /// 指定当前表单项的[label]对齐方式
  final ElFormLabelAlign labelAlign;

  ElFormItemData({
    required this.label,
    required this.prop,
    required this.required,
    required this.labelWidth,
    required this.labelPosition,
    required this.labelAlign,
  });
}

class _ElFormItemInheritedWidget extends InheritedWidget {
  const _ElFormItemInheritedWidget({
    required super.child,
    required this.data,
  });

  final ElFormItemData data;

  static ElFormItemData? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElFormItemInheritedWidget>()
      ?.data;

  @override
  bool updateShouldNotify(_ElFormItemInheritedWidget oldWidget) => true;
}
