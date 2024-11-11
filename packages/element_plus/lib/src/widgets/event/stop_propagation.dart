part of 'index.dart';

class ElStopPropagation extends InheritedWidget {
  /// 阻止事件冒泡小部件
  const ElStopPropagation({
    super.key,
    required super.child,
  });

  /// 从当前上下文获取 [ElStopPropagation] 实例，并以 [ElStopPropagation] 实例所在 Element Tree 的位置执行阻止冒泡函数，
  /// 此函数由支持事件冒泡的小部件调用，并不需要暴露给用户
  static void _of(
    BuildContext context,
    void Function(BuildContext context) stopPropagation,
  ) {
    final result =
        context.getElementForInheritedWidgetOfExactType<ElStopPropagation>();
    if (result != null) stopPropagation(result);
  }

  @override
  bool updateShouldNotify(ElStopPropagation oldWidget) => false;
}



