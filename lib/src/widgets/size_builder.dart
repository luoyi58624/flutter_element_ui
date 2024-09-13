import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

class ElSizeBuilder extends StatefulWidget {
  const ElSizeBuilder({
    super.key,
    this.delay = 16,
    required this.builder,
  });

  final int delay;
  final Widget Function(BuildContext context, Size size) builder;

  @override
  State<ElSizeBuilder> createState() => _ElSizeBuilderState();
}

class _ElSizeBuilderState extends State<ElSizeBuilder> {
  Size size = Size.zero;
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      () {
        setState(() {
          size = context.size!;
        });
        () {
          flag = true;
        }.delay(16);
      }.delay(widget.delay);
    }
    return widget.builder(context, size);
  }
}
