import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/global.dart';

abstract class ElModelValueHook<D> extends HookWidget {
  /// [ElModelValue] Hook版本
  const ElModelValueHook(
    this.modelValue, {
    super.key,
    this.onChanged,
  });

  /// 同时支持基本数据类型和响应式类型，如果是 [ValueNotifier] 类型，
  /// 则无需监听 [onChanged] 手动更改变量状态
  final dynamic modelValue;

  /// 变量更新事件，任何一个支持双向绑定的小部件都一定会提供监听变化事件
  final ValueChanged<D>? onChanged;

  /// 是否是响应式类型
  bool get isReactive {
    if (modelValue is ValueNotifier) {
      assert(modelValue is ValueNotifier<D>, '${toString()} 接收的响应式参数必须是 $D 类型');
      return true;
    } else {
      assert(modelValue is D, '${toString()} 接收的参数必须是 $D 类型');
      return false;
    }
  }

  /// 如果是[ValueNotifier]，将返回原始数据类型
  D get $modelValue => isReactive ? modelValue.value : modelValue;

  /// 更新变量，同时处理 [ValueNotifier] 和 onChange 事件
  set $modelValue(D v) {
    if (isReactive) modelValue.value = v;
    if (onChanged != null) onChanged!(v);
  }

  /// 取代 [build] 方法构建小部件，自动适配响应式小部件
  Widget builder(BuildContext context, D value);

  @override
  Widget build(BuildContext context) {
    if (isReactive) {
      return ValueListenableBuilder(
        valueListenable: modelValue,
        builder: (context, status, _) {
          return _HookWidget(child: builder(context, status as D));
        },
      );
    } else {
      return builder(context, modelValue as D);
    }
  }
}

class _HookWidget extends HookWidget {
  const _HookWidget({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
