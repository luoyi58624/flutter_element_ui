import 'package:flutter_element_ui/src/global.dart';

class ElBody extends StatelessWidget {
  const ElBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.elTheme.colors.bg,
      child: SizedBox(
        child: child,
      ),
    );
  }
}
