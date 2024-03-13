part of flutter_element_ui;

abstract class _DesktopEventWidget extends StatelessWidget {
  const _DesktopEventWidget({
    required this.onPressed,
    required this.onHover,
    required this.onTap,
  });

  final VoidCallback? onPressed;
  final bool onHover;
  final bool onTap;

  @override
  Widget build(BuildContext context);
}
