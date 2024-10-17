import 'package:flutter/widgets.dart';

abstract class ModelValue<D> extends StatefulWidget {
  /// Element UI 实现小部件双向绑定抽象类
  const ModelValue(
    this.modelValue, {
    super.key,
    this.onChanged,
  });

  /// 同时支持基本数据类型和响应式类型，如果是 [ValueNotifier] 类型，
  /// 则无需监听 [onChanged] 手动更改变量状态
  final dynamic modelValue;

  /// 变量更新事件
  final ValueChanged<D>? onChanged;

  @override
  State<ModelValue<D>> createState();
}

abstract class ModelValueState<T extends ModelValue<D>, D>
    extends State<T> {
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

  /// 如果是[ValueNotifier]，将返回原始数据类型
  D get modelValue => isReactive ? widget.modelValue.value : widget.modelValue;

  /// 更新变量，同时处理 [ValueNotifier] 和 onChange 事件
  set modelValue(D v) {
    if (isReactive) widget.modelValue.value = v;
    if (widget.onChanged != null) widget.onChanged!(v);
  }

  /// 取代 [build] 方法构建小部件，自动适配响应式小部件
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
