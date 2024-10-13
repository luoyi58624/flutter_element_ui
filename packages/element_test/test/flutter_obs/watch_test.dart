import 'package:flutter/material.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:flutter_test/flutter_test.dart';

Key switch1 = const Key('switch1');
Key switch2 = const Key('switch2');

/// ObsBuilder watch 测试
void watchTest() {
  testWidgets('内存泄漏测试2', (tester) async {
    await tester.pumpWidget(const _Test1());
    expect(find.text('buildCount: 0'), findsOneWidget);
    await tester.tap(find.text('count1++'));
    await tester.pump();
    expect(find.text('buildCount: 0'), findsOneWidget);

    // 监听 count1
    await tester.tap(find.byKey(switch1));
    await tester.pumpAndSettle();
    await tester.tap(find.text('count1++'));
    await tester.pump();
    expect(find.text('buildCount: 1'), findsOneWidget);
    await tester.tap(find.text('count2++')); // 只监听了count1，所以count2++无变化
    await tester.pump();
    expect(find.text('buildCount: 1'), findsOneWidget);

    // 监听 count1、count2
    await tester.tap(find.byKey(switch2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('count1++'));
    await tester.pump();
    await tester.tap(find.text('count2++'));
    await tester.pump();
    expect(find.text('buildCount: 2'), findsOneWidget);

    // 不监听count2
    await tester.tap(find.byKey(switch2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('count1++'));
    await tester.pump();
    await tester.tap(find.text('count2++'));
    await tester.pump();
    expect(find.text('buildCount: 1'), findsOneWidget);

    // 不监听count1
    await tester.tap(find.byKey(switch1));
    await tester.pumpAndSettle();
    await tester.tap(find.text('count1++'));
    await tester.pump();
    await tester.tap(find.text('count2++'));
    await tester.pump();
    expect(find.text('buildCount: 0'), findsOneWidget);
  });
}

class _Test1 extends StatefulWidget {
  const _Test1();

  @override
  State<_Test1> createState() => _Test1State();
}

class _Test1State extends State<_Test1> {
  final count1 = Obs(0);
  final count2 = Obs(0);

  bool flag1 = false;
  bool flag2 = false;

  int buildCount = -1;

  @override
  Widget build(BuildContext context) {
    buildCount = -1;
    return MaterialApp(
      home: Material(
        child: Column(
          children: [
            Switch(
              key: switch1,
              value: flag1,
              onChanged: (v) => setState(() {
                flag1 = v;
              }),
            ),
            Switch(
              key: switch2,
              value: flag2,
              onChanged: (v) => setState(() {
                flag2 = v;
              }),
            ),
            GestureDetector(
              onTap: () {
                count1.value++;
              },
              child: ObsBuilder(builder: (context) {
                return const Text('count1++');
              }),
            ),
            GestureDetector(
              onTap: () {
                count2.value++;
              },
              child: ObsBuilder(builder: (context) {
                return const Text('count2++');
              }),
            ),
            ObsBuilder(
              watch: [
                if (flag1) count1,
                if (flag2) count2,
              ],
              builder: (context) {
                buildCount++;
                return Text('buildCount: $buildCount');
              },
            ),
          ],
        ),
      ),
    );
  }
}
