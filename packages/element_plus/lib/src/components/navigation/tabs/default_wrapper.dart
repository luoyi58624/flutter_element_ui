part of 'index.dart';

class _TabsWrapper extends StatelessWidget {
  /// Element UI 默认的标签容器外观实现
  const _TabsWrapper({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final $theme = ElTabsTheme.of(context);
    final size = $theme.size!;
    final axis = axisDirectionToAxis($theme.direction!);

    return Container(
      width: axis == Axis.vertical ? size : null,
      height: axis == Axis.horizontal ? size : null,
      color: $theme.bgColor,
      child: child,
    );
  }
}
