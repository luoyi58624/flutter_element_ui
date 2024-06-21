import 'package:flutter/widgets.dart';

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

/// 用于向子组件共享的表单数据
class ElFormInheritedWidget extends InheritedWidget {
  const ElFormInheritedWidget({
    super.key,
    required super.child,
    this.labelWidth,
    required this.labelPosition,
    required this.labelAlign,
  });

  final double? labelWidth;
  final ElFormLabelPosition labelPosition;
  final ElFormLabelAlign labelAlign;

  /// 子孙组件通过of获取的数据，当父组件发生更改时将会自动重建，
  /// dependOnInheritedWidgetOfExactType表示通知依赖它的组件重新构建
  static ElFormInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ElFormInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
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
  final Map<String, dynamic> model;

  /// [FormItemWidget] label的默认宽度
  final double? labelWidth;

  /// [FormItemWidget] label的默认位置
  final ElFormLabelPosition labelPosition;

  /// [FormItemWidget] label的默认对齐方式
  final ElFormLabelAlign labelAlign;

  @override
  State<ElForm> createState() => _ElFormState();
}

class _ElFormState extends State<ElForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ElFormInheritedWidget(
      labelWidth: widget.labelWidth,
      labelPosition: widget.labelPosition,
      labelAlign: widget.labelAlign,
      child: Form(
        key: formKey,
        child: widget.child,
      ),
    );
  }
}
