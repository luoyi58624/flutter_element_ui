part of 'layout.dart';

class ElMain extends ElLayoutWidget {
  /// Element UI 主页面布局组件，它会分配[ElLayout]内部所有的剩余空间，
  const ElMain({
    super.key,
    required this.child,
    this.bgColor,
    this.flex = 1,
  });

  /// 子组件
  final Widget child;

  /// 自定义背景色
  final Color? bgColor;

  /// 分配的空间比例
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: AnimatedContainer(
        duration: Duration(milliseconds: context.elConfig.bgColorTransition),
        width: double.infinity,
        height: double.infinity,
        color: bgColor ?? context.elTheme.bgColor,
        child: child,
      ),
    );
  }
}
