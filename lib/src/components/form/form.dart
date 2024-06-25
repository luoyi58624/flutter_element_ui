import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

/// label所在的位置
enum ElFormLabelPosition {
  /// label在左，formItem在右
  left,

  /// label在上，formItem在下
  top,
}

/// label对齐方式，注意：使用 LabelPosition.top 只能左对齐（为了更好看）
enum ElFormLabelAlign {
  start, // 左对齐
  center, // 居中对齐
  end, // 右对齐
}

/// 文本框输入类型
enum ElFormTextInputType {
  text, // 允许所有文字
  number, // 只允许输入数字
  password, // 密码，注意：若文本框为密码类型，则不会显示清除图标
}

class ElForm extends StatefulWidget {
  const ElForm({
    super.key,
    required this.model,
    required this.child,
    this.labelWidth,
    this.labelPosition = ElFormLabelPosition.left,
    this.labelAlign = ElFormLabelAlign.start,
  });

  final Widget child;

  /// 表单数据
  final Obs<Map<String, dynamic>> model;

  /// [FormItemWidget] label的默认宽度
  final double? labelWidth;

  /// [FormItemWidget] label的默认位置
  final ElFormLabelPosition labelPosition;

  /// [FormItemWidget] label的默认对齐方式
  final ElFormLabelAlign labelAlign;

  /// 从当前上下文获取表单数据
  static ElFormData of(BuildContext context) =>
      _ElFormInheritedWidget.of(context);

  @override
  State<ElForm> createState() => _ElFormState();
}

class _ElFormState extends State<ElForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _ElFormInheritedWidget(
      data: ElFormData(
        model: widget.model,
        labelWidth: widget.labelWidth,
        labelPosition: widget.labelPosition,
        labelAlign: widget.labelAlign,
      ),
      child: Form(
        key: formKey,
        child: widget.child,
      ),
    );
  }
}

class ElFormData {
  /// 表单模型数据
  final Obs<Map<String, dynamic>> model;

  /// [FormItemWidget] label的默认宽度
  final double? labelWidth;

  /// [FormItemWidget] label的默认位置
  final ElFormLabelPosition labelPosition;

  /// [FormItemWidget] label的默认对齐方式
  final ElFormLabelAlign labelAlign;

  ElFormData({
    required this.model,
    required this.labelWidth,
    required this.labelPosition,
    required this.labelAlign,
  });
}

class _ElFormInheritedWidget extends InheritedWidget {
  const _ElFormInheritedWidget({
    required super.child,
    required this.data,
  });

  final ElFormData data;

  static ElFormData of(BuildContext context) {
    final _ElFormInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ElFormInheritedWidget>();
    assert(result != null, 'No _ElFormInheritedWidget found in context');
    return result!.data;
  }

  @override
  bool updateShouldNotify(_ElFormInheritedWidget oldWidget) => true;
}
