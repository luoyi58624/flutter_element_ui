import 'package:flutter/widgets.dart';

class ElNavbar extends StatefulWidget {
  const ElNavbar({
    super.key,
    this.child,
    this.height = 56,
  });

  final Widget? child;
  final double height;

  @override
  State<ElNavbar> createState() => _ElNavbarState();
}

class _ElNavbarState extends State<ElNavbar> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
