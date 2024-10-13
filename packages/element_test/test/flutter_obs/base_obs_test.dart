import 'package:flutter/material.dart';
import 'package:flutter_obs/src/base_obs.dart';
import 'package:flutter_obs/src/obs.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common.dart';

void baseObsTest() {
  testWidgets('测试 BaseObs', (tester) async {
    final count = BaseObs(0);

    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            push(
              context,
              ChildPage(
                child: GestureDetector(
                  onTap: () {
                    count.value++;
                  },
                  child: ObsBuilder(builder: (context) {
                    return Text('count: ${count.value}');
                  }),
                ),
              ),
            );
          },
          child: const Text('child page'),
        );
      }),
    ));

    await tester.tap(find.text('child page'));
    await tester.pumpAndSettle();
    expect(ObsTest.getBuilderFunLength(count), 1);
    await tester.tap(find.text('count: 0'));
    await tester.pump();
    expect(find.text('count: 1'), findsOneWidget);
    await tester.tap(find.text('back'));
    await tester.pumpAndSettle();
    expect(ObsTest.getBuilderFunLength(count), 0);
  });
}