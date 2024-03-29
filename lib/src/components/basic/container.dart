part of flutter_element_ui;

class ElContainer extends StatelessWidget {
  const ElContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 1280,
          padding: const EdgeInsets.only(top: 16),
          child: child,
        ),
      ),
    );
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
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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
    return ColoredBox(
      color: ElAppData.of(context).currentTheme.mainColor,
      child: child,
    );
  }
}
