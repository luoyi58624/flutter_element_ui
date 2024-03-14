part of flutter_element_ui;

class ElButtonGroup extends StatefulWidget {
  const ElButtonGroup({super.key, required this.children});

  final List<ElButton> children;

  @override
  State<ElButtonGroup> createState() => _ElButtonGroupState();
}

class _ElButtonGroupState extends State<ElButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.children,
    );
  }
}
