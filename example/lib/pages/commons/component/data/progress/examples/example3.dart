import 'package:example/global.dart';
import 'package:flutter/material.dart';

class Example3 extends HookWidget {
  const Example3({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: [
            SizedBox(
              height: 100,
              child: Row(
                  children: AxisDirection.values
                      .map((e) => Expanded(
                            child: ElProgress.animate(90, axis: e),
                          ))
                      .toList()),
            ),
          ],
        ),
      ],
    );
  }
}

String get code => '''
SizedBox(
  height: 300,
  child: ElProgress(50, axis: AxisDirection.up),
),''';
