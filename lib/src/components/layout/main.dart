part of 'layout.dart';

class ElMain extends ElLayoutWidget {
  const ElMain({
    super.key,
    required this.child,
    this.bgColor,
  });

  final Widget child;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
