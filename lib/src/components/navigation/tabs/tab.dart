part of 'tabs.dart';

class ElTab extends StatelessWidget {
  const ElTab({
    super.key,
    required this.title,
    this.disabled = false,
    this.closable = true,
  });

  /// 标签标题
  final String title;

  /// 是否禁用
  final bool disabled;

  /// 是否显示关闭按钮
  final bool closable;

  @override
  Widget build(BuildContext context) {
    final $data = _TabsInheritedWidget.of(context);
    final $indexData = ElChildIndexData.of(context);
    late Widget result;
    if ($data.type == ElTabType.google) {
      result = const _GoogleTab();
    }
    return _TabInheritedWidget(
      title,
      disabled,
      closable,
      child: GestureDetector(
        onTapDown: (e) {
          $data.modelValue.value = $indexData.index;
        },
        child: HoverBuilder(builder: (context) {
          return result;
        }),
      ),
    );
  }
}

class _TabInheritedWidget extends InheritedWidget {
  const _TabInheritedWidget(
    this.title,
    this.disabled,
    this.closable, {
    required super.child,
  });

  final String title;
  final bool disabled;
  final bool closable;

  static _TabInheritedWidget of(BuildContext context) {
    final _TabInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_TabInheritedWidget>();
    assert(result != null, 'No _TabInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_TabInheritedWidget oldWidget) => true;
}
