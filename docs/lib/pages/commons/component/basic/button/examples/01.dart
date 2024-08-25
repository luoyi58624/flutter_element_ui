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
            const Gap(28),
            H4(title),
            const Gap(16),
          ],
        );
    Widget buildWrap(Iterable<Widget> children) =>
        Wrap(spacing: 8, runSpacing: 8, children: children.toList());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('基础用法'),
        CodeExampleWidget(
          code: code1,
          child: Column(
            children: [
              buildWrap(
                buttonTypes.map(
                  (type) => ElButton(
                    child: (type ?? 'Default').firstUpperCase,
                    onPressed: null,
                    type: type,
                  ),
                ),
              ),
              buildWrap(
                buttonTypes.map(
                  (type) => ElButton(
                    child: (type ?? 'Default').firstUpperCase,
                    onPressed: null,
                    type: type,
                    plain: true,
                  ),
                ),
              ),
              buildWrap(
                buttonTypes.map(
                  (type) => ElButton(
                    child: (type ?? 'Default').firstUpperCase,
                    onPressed: null,
                    type: type,
                    round: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String get code1 => '''
ElButton(onPressed: () {}, child: 'Default'),
ElButton(onPressed: () {}, child: 'Primary', type: 'primary'),
ElButton(onPressed: () {}, child: 'Primary', type: 'primary', plain: 'true'),
ElButton(onPressed: () {}, child: 'Primary', type: 'primary', round: 'true'),''';
