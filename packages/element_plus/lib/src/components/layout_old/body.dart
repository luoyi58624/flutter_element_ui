import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

class ElBody extends StatelessWidget {
  const ElBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.elTheme.layoutTheme.bgColor!,
      child: SizedBox(
        child: child,
      ),
    );
  }
}
