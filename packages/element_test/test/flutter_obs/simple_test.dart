import 'package:flutter/material.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:flutter_obs/src/obs.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common.dart';

void simpleTest() {
  testWidgets('局部状态测试', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LocalStateWidget('count'),
    ));

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
    expect(find.text('count: 1'), findsOneWidget);
    await tester.tap(find.byType(GestureDetector));
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
    expect(find.text('count: 3'), findsOneWidget);

    // 重新挂载小部件，状态将被重置
    await tester.pumpWidget(const MaterialApp(
      home: LocalStateWidget('count'),
    ));
    expect(find.text('count: 0'), findsOneWidget);
  });

  testWidgets('测试 ListenableBuilder、ValueListenableBuilder', (tester) async {
    final count = Obs(0);
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return Column(
          children: [
            ObsBuilder(
              builder: (context) {
                return Text('ObsBuilder: $count');
              },
            ),
            ListenableBuilder(
              listenable: count,
              builder: (context, child) {
                return Text('ListenableBuilder: $count');
              },
            ),
            ValueListenableBuilder(
              valueListenable: count,
              builder: (context, value, child) {
                return Text('ValueListenableBuilder: $value');
              },
            ),
          ],
        );
      }),
    ));

    count.value = 100;

    await tester.pump();
    expect(find.text('ObsBuilder: 100'), findsOneWidget);
    expect(find.text('ListenableBuilder: 100'), findsOneWidget);
    expect(find.text('ListenableBuilder: 100'), findsOneWidget);
  });

  /// 当父组件发生变更时，局部状态会被重置，但如果使用 const 修饰，则依旧可以保持状态
  testWidgets('局部状态重新构建测试', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: _Test2(),
    ));

    await tester.tap(find.text('count1: 0'));
    await tester.tap(find.text('count2: 0'));
    await tester.pump();
    expect(find.text('count1: 1'), findsOneWidget);
    expect(find.text('count2: 1'), findsOneWidget);

    await tester.tap(find.text('count: 0'));
    await tester.pump();
    expect(find.text('count1: 0'), findsOneWidget);
    expect(find.text('count2: 1'), findsOneWidget);
  });

  /// Obs变量可以放置任意位置，当放在组件外部时它将变成全局响应式变量
  testWidgets('全局状态测试', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: _Test3(),
    ));
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();
    expect(find.text('count3: 1'), findsOneWidget);

    // 重新挂载小部件，状态不会重置
    await tester.pumpWidget(const MaterialApp(
      home: _Test3(),
    ));
    expect(find.text('count3: 1'), findsOneWidget);
  });

  /// 当退出页面时，保存的状态将被重置
  testWidgets('状态路由测试', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            push(
              context,
              const ChildPage(child: LocalStateWidget('count')),
            );
          },
          child: const Text('child page'),
        );
      }),
    ));

    await tester.tap(find.text('child page'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('count: 0'));
    await tester.pump();
    expect(find.text('count: 1'), findsOneWidget);
    await tester.tap(find.text('back'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('child page'));
    await tester.pumpAndSettle();
    expect(find.text('count: 0'), findsOneWidget);
  });

  testWidgets('退出路由后监听函数是否被清除', (tester) async {
    final count = Obs(0);

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
    await tester.tap(find.text('back'));
    await tester.pumpAndSettle();
    expect(ObsTest.getBuilderFunLength(count), 0);
  });
}

class _Test2 extends StatefulWidget {
  const _Test2();

  @override
  State<_Test2> createState() => _Test2State();
}

class _Test2State extends State<_Test2> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              count++;
            });
          },
          child: Text('count: $count'),
        ),
        // ignore: prefer_const_constructors
        LocalStateWidget('count1'),
        const LocalStateWidget('count2'),
      ],
    );
  }
}

final count3 = Obs(0);

class _Test3 extends StatelessWidget {
  const _Test3();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        count3.value++;
      },
      child: ObsBuilder(builder: (context) {
        return Text('count3: ${count3.value}');
      }),
    );
  }
}
