part of flutter_element_ui;

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

/// 表单尺寸
enum ElFormSize {
  small, // 小
  medium, // 中
  large, // 大
}

/// 文本框输入类型
enum ElFormTextInputType {
  text, // 允许所有文字
  number, // 只允许输入数字
  password, // 密码，注意：若文本框为密码类型，则不会显示清除图标
}

/// 标签文字大小
const Map<ElFormSize, double> _labelFontSize = {
  ElFormSize.small: 12.0,
  ElFormSize.medium: 14.0,
  ElFormSize.large: 16.0,
};

/// 提示文字大小
const Map<ElFormSize, double> _hintFontSize = {
  ElFormSize.small: 10.0,
  ElFormSize.medium: 12.0,
  ElFormSize.large: 14.0,
};

/// 前缀图标大小
const Map<ElFormSize, double> _formIconSize = {
  ElFormSize.small: 16.0,
  ElFormSize.medium: 18.0,
  ElFormSize.large: 20.0,
};

/// 文本框上下内边距
const Map<ElFormSize, double> _inputPadding = {
  ElFormSize.small: 10.0,
  ElFormSize.medium: 12.0,
  ElFormSize.large: 14.0,
};

/// 用于向子组件共享的表单数据
class _FormInheritedWidget extends InheritedWidget {
  const _FormInheritedWidget({
    super.key,
    required super.child,
    this.labelWidth,
    required this.labelPosition,
    required this.labelAlign,
    required this.size,
  });

  final double? labelWidth;
  final ElFormLabelPosition labelPosition;
  final ElFormLabelAlign labelAlign;
  final ElFormSize size;

  /// 子孙组件通过of获取的数据，当父组件发生更改时将会自动重建，
  /// dependOnInheritedWidgetOfExactType表示通知依赖它的组件重新构建
  static _FormInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_FormInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class ElForm extends StatefulWidget {
  const ElForm({
    super.key,
    required this.child,
    required this.data,
    this.labelWidth,
    this.labelPosition = ElFormLabelPosition.left,
    this.labelAlign = ElFormLabelAlign.start,
    this.size = ElFormSize.medium,
  });

  final Widget child;

  /// 表单数据
  final Map<String, dynamic> data;

  /// [FormItemWidget] label的默认宽度
  final double? labelWidth;

  /// [FormItemWidget] label的默认位置
  final ElFormLabelPosition labelPosition;

  /// [FormItemWidget] label的默认对齐方式
  final ElFormLabelAlign labelAlign;

  /// 表单整体大小
  final ElFormSize size;

  @override
  State<ElForm> createState() => _ElFormState();
}

class _ElFormState extends State<ElForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _FormInheritedWidget(
      labelWidth: widget.labelWidth,
      labelPosition: widget.labelPosition,
      labelAlign: widget.labelAlign,
      size: widget.size,
      child: Form(
        key: formKey,
        child: widget.child,
      ),
    );
  }
}
