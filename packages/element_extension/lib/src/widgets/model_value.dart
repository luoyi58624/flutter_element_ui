import 'package:flutter/widgets.dart';

/// 双向绑定小部件抽象类，当传递 [ValueNotifier] 类型数据时，将无需在 onChanged 事件中手动更新状态
abstract class ModelValue<D> extends StatefulWidget {
  const ModelValue(
    this.modelValue, {
    super.key,
    this.onChanged,
  });

  /// 模型数据，它同时支持基本数据类型和响应式类型
  final dynamic modelValue;

  /// 变量更新事件
  final ValueChanged<D>? onChanged;

  @override
  State<ModelValue<D>> createState();
}

abstract class ModelValueState<T extends ModelValue<D>, D> extends State<T> {
  /// 是否是响应式类型
  bool get isReactive {
    if (widget.modelValue is ValueNotifier) {
      assert(widget.modelValue is ValueNotifier<D>,
          '${widget.toString()} 接收的响应式参数必须是 $D 类型');
      return true;
    } else {
      assert(widget.modelValue is D, '${widget.toString()} 接收的参数必须是 $D 类型');
      return false;
    }
  }

  /// 返回原始数据类型，如果是 [ValueNotifier] 则自动取 .value 值
  D get modelValue => isReactive ? widget.modelValue.value : widget.modelValue;

  /// 更新变量，同时处理 [ValueNotifier] 和 onChange 事件
  set modelValue(D v) {
    if (isReactive) widget.modelValue.value = v;
    if (widget.onChanged != null) widget.onChanged!(v);
  }

  /// 构建小部件，此方法会自动适配响应式
  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (isReactive) {
      return ValueListenableBuilder(
        valueListenable: widget.modelValue,
        builder: (context, status, _) {
          return builder(context);
        },
      );
    } else {
      return builder(context);
    }
  }
}
