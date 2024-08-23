import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonTypes = [null, ...el.themeTypes];
    Widget buildTitle(String title) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(16),
            H4(title),
            const Gap(8),
          ],
        );
    Widget buildWrap(Iterable<Widget> children) =>
        Wrap(spacing: 8, runSpacing: 8, children: children.toList());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('普通按钮'),
        buildWrap(buttonTypes.map(
          (type) => ElButton(
            child: (type ?? 'Default').substring(0, 1).toUpperCase() +
                (type ?? 'Default').substring(1),
            onPressed: null,
            type: type,
          ),
        )),
      ],
    );
  }
}
