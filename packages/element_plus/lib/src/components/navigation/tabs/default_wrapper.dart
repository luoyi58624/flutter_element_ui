part of 'index.dart';

class ElTabsWrapper extends StatelessWidget {
  /// Element UI 默认的标签容器外观实现
  const ElTabsWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final data = ElTabs.of(context);
    final size = data.size;
    final axis = data.axis;
    return Container(
      width: axis == Axis.vertical ? size : null,
      height: axis == Axis.horizontal ? size : null,
      color: data.bgColor,
      child: child,
    );
  }
}
