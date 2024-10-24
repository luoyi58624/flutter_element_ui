import 'package:flutter/widgets.dart';

/// 双向绑定小部件抽象类，当传递 [ValueNotifier] 类型数据时，
/// 将无需在 onChanged 事件中手动更新状态
abstract class ElModelValue<D> extends StatefulWidget {
  const ElModelValue(
    this.modelValue, {
    super.key,
    this.onChanged,
  });

  /// 模型数据，它同时支持基本数据类型和响应式类型
  final dynamic modelValue;

  /// 变量更新事件
  final ValueChanged<D>? onChanged;

  @override
  State<ElModelValue<D>> createState();
}

abstract class ElModelValueState<T extends ElModelValue<D>, D>
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

class ElChildIndex extends InheritedWidget {
  /// 一个功能小部件，让迭代的列表子元素确认自身所在的位置
  const ElChildIndex({
    super.key,
    required super.child,
    required this.index,
    this.start,
    this.end,
    this.length,
  });

  /// 当前索引
  final int index;

  /// 迭代元素起始索引，非必需，使用前请确认是否注入
  final int? start;

  /// 迭代元素结束索引，非必需，使用前请确认是否注入
  final int? end;

  /// 迭代元素总长度，非必需，使用前请确认是否注入
  final int? length;

  static ElChildIndex? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElChildIndex>();

  static ElChildIndex of(BuildContext context) {
    final ElChildIndex? result = maybeOf(context);
    assert(result != null, 'No ElChildIndex found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElChildIndex oldWidget) => true;
}
