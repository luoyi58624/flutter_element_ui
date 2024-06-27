part of 'layout.dart';

/// Element UI 侧边栏布局组件，侧边栏宽度跟随子元素
class ElAside extends ElLayoutWidget {
  const ElAside({
    super.key,
    required this.child,
    this.bgColor,
  });

  final Widget child;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: AnimatedColoredBox(
        duration: Duration(milliseconds: context.elConfig.bgColorTransition),
        color: bgColor ?? context.elTheme.asideBgColor,
        child: SizedBox(
          height: double.infinity,
          child: child,
        ),
      ),
    );
  }
}
