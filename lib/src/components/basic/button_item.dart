part of flutter_element_ui;

abstract class _ButtonItem extends StatefulWidget {
  const _ButtonItem({
    required super.key,
  }) : assert(key is ValueKey<int>, '请传递包含当前按钮索引的ValueKey');

  @override
  State<_ButtonItem> createState();
}

abstract class _ButtonItemState<T extends _ButtonItem> extends State<T> {
  /// 按钮当前索引的key
  late int currentIndex = (widget.key as ValueKey<int>).value;

  /// 按钮组数据
  late _ElButtonGroupData buttonGroupData =  _ElButtonGroupData.of(context);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/// 按钮组的按钮项，你必须设置当前下标key，用于定位当前按钮所在的位置。
///
/// 例：
/// ```dart
/// const ElButtonGroup(
///   children: [
///     ElButtonItem(
///       key: ValueKey(0), // 下标位置
///       'Item 1',
///     ),
///     ElButtonItem(
///        key: ValueKey(1),
///       'Item 2',
///     ),
///   ],
/// ),
class ElButtonItem extends _ButtonItem {
  const ElButtonItem(
    this.text, {
    required super.key,
    this.leftIcon,
    this.rightIcon,
    this.disabled = false,
  });

  /// 按钮文字
  final String? text;

  /// 普通按钮左图标
  final IconData? leftIcon;

  /// 普通按钮右图标
  final IconData? rightIcon;

  /// 禁用按钮
  final bool disabled;

  @override
  State<ElButtonItem> createState() => _ElButtonItemState();
}

class _ElButtonItemState extends _ButtonItemState<ElButtonItem> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ElIconButtonItem extends StatefulWidget {
  const ElIconButtonItem(
    this.icon, {
    required super.key,
  }) : assert(key is ValueKey<int>, '请传递包含当前按钮索引的ValueKey');

  /// 按钮图标
  final ElIcon? icon;

  @override
  State<ElIconButtonItem> createState() => _ElIconButtonItemState();
}

class _ElIconButtonItemState extends State<ElIconButtonItem> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
