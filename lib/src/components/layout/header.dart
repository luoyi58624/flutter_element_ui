part of 'layout.dart';

/// Element UI 头部布局组件
class ElHeader extends ElLayoutWidget {
  const ElHeader({
    super.key,
    required this.child,
    this.height = 56,
    this.bgColor,
  });

  final Widget child;
  final double height;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: AnimatedContainer(
        duration: Duration(milliseconds: context.elConfig.bgColorTransition),
        color: bgColor ?? context.elTheme.headerColor,
        height: height,
        width: double.infinity,
        child: child,
      ),
    );
  }
}
