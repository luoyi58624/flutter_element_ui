import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('基础用法'),
        CodeExampleWidget(code: code1, children: [
          Wrap(
            children: ElIcons.values
                .map(
                  (e) => ElIcon(e),
                )
                .toList(),
          )
        ]),
      ],
    );
  }
}

String get code1 => '''
ElButton(onPressed: () {}, child: 'Default'),
ElButton(onPressed: () {}, child: 'Primary', type: 'primary'),
ElButton(onPressed: () {}, child: 'Primary', type: 'success', plain: true),
ElButton(onPressed: () {}, child: 'Primary', type: 'warning', round: true),
ElButton(onPressed: () {}, child: const ElIcon(ElIcons.aim)),
ElButton(onPressed: () {}, child: const ElIcon(ElIcons.aim), circle: true)''';
