import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class ElBody extends StatelessWidget {
  const ElBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.elTheme.bgColor,
      child: SizedBox(
        child: child,
      ),
    );
  }
}
