part of flutter_element_ui;

class ElContainer extends StatelessWidget {
  const ElContainer({super.key, required this.children});

  final List<ElChildContainer> children;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

abstract class ElChildContainer extends StatelessWidget {
  const ElChildContainer({super.key});
}

class ElHeader extends ElChildContainer {
  const ElHeader({
    super.key,
    required this.child,
    this.height = 56,
    this.padding,
  });

  final Widget child;
  final double height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      color: ElAppData.of(context).currentTheme.headerColor,
      child: child,
    );
  }
}

class ElMain extends ElChildContainer {
  const ElMain({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: ElAppData.of(context).currentTheme.mainColor,
      child: child,
    );
  }
}
