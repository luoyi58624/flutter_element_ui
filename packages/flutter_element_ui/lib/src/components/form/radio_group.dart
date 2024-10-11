part of 'radio.dart';

class ElRadioGroup<T> extends StatelessWidget {
  /// 单选框组，通过[value]、[onChanged]用来明确当前选中的值，
  const ElRadioGroup({
    super.key,
    required this.onChanged,
    required this.value,
    required this.children,
    this.border = false,
  });

  /// 选中的值
  final T? value;

  /// [ElRadio]集合
  final List<ElRadio<T>> children;

  /// 是否显示边框
  final bool border;

  /// 选中的值发生变化事件
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return _ElRadioGroupInheritedWidget<T>(
      value: value,
      onChanged: onChanged,
      child: Row(
        children: children,
      ),
    );
  }
}

class _ElRadioGroupInheritedWidget<T> extends InheritedWidget {
  const _ElRadioGroupInheritedWidget({
    super.key,
    required super.child,
    required this.value,
    required this.onChanged,
  });

  final T? value;

  final ValueChanged<T?>? onChanged;

  static _ElRadioGroupInheritedWidget<T>? of<T>(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElRadioGroupInheritedWidget<T>>();

  @override
  bool updateShouldNotify(_ElRadioGroupInheritedWidget oldWidget) => true;
}
