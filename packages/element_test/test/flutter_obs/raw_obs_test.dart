import 'package:flutter/material.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:flutter_obs/src/obs.dart';
import 'package:flutter_test/flutter_test.dart';

import '../element_generates/models/clone_model.dart';
import 'common.dart';

void rawObsTest() {
  testWidgets('测试 RawObs', (tester) async {
    final count = RawObs(0);

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

  testWidgets('Obs initialValue 对象克隆测试', (tester) async {
    final model = Obs(CloneModel(
      name: 'hihi',
      age: 20,
    ));

    model.value.name = 'xx';
    expect(model.initialValue.name, 'xx');

    final model2 = Obs(CloneModel3(
      name: 'hihi',
      age: 20,
    ));

    model2.value.name = 'xx';
    expect(model2.initialValue.name, 'hihi');
  });

  testWidgets('RawObs initialValue List 数组测试', (tester) async {
    final list = ImmutableObs([0, 1]);

    list.value[0] = -1;
    expect(list.initialValue[0], -1);

    list.value.add(2);
    expect(list.initialValue, [-1, 1, 2]);
  });
}
