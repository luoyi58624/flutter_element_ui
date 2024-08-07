import 'package:flutter/widgets.dart';

class ElAnimateUtil {}

class ElAnimate extends StatefulWidget {
  const ElAnimate({super.key});

  @override
  State<ElAnimate> createState() => _ElAnimateState();
}

class _ElAnimateState extends State<ElAnimate>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this);
  final Tween doubleTween = Tween<double>(begin: -200.0, end: 0.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
