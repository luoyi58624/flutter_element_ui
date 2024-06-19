import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extension.dart';

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
