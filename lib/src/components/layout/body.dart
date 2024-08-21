import 'package:flutter/widgets.dart';

import '../../service.dart';

class ElBody extends StatelessWidget {
  const ElBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: el.theme.bgColor,
      child: SizedBox(
        child: child,
      ),
    );
  }
}
