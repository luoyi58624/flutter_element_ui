import 'package:flutter/material.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:flutter_obs/src/obs.dart';
import 'package:flutter_test/flutter_test.dart';

import 'common.dart';

/// 模拟复杂的应用场景，检测是否存在内存泄漏，检测是否泄漏的核心点就是判断 ObsBuilder 刷新方法集合是否被正确移除
void memoryLeakTest() {
  testWidgets('内存泄漏测试1', (tester) async {
    GlobalState state = GlobalState(false);
    expect(state.count.value, 0);
    expect(state.activeCountWatch, false);
    // 对于嵌套 ObsBuilder，更新内部响应式变量不会影响外部
    await tester.pumpWidget(_MainApp(
      state: state,
      child: const _NestBuilder(),
    ));
    expect(state.activeCountWatch, false);
    expect(find.text('parentUpdateCount: 0'), findsOneWidget);
    await tester.tap(find.text('count1: 0'));
    await tester.pump();
    expect(state.activeCountWatch, true);
    expect(find.text('parentUpdateCount: 0'), findsOneWidget);
    expect(ObsTest.getBuilderFunLength(state.count), 1);
    // 移除、重新建立连接
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(find.text('parentUpdateCount: 2'), findsOneWidget);
    // 点击count1，发现外部 ObsBuilder 也会发生构建
    await tester.tap(find.text('count1: 1'));
    await tester.pump();
    // 这是一个已知的bug，当内部的响应式构造器重新建立连接时，外部监听器没有移除，
    // 所以执行内部点击时会造成外部 ObsBuilder 也发生重建，这种写法应当避免
    expect(find.text('parentUpdateCount: 3'), findsOneWidget);
    expect(ObsTest.getBuilderFunLength(state.count), 2);
  });

  testWidgets('内存泄漏测试2', (tester) async {
    // 模拟监听函数需要立即触发
    GlobalState state = GlobalState(true);
    // count使用了 late 修饰，所以判断监听函数是否触发前需要先使用它，这里只是做了判断，并未做修改
    expect(state.count.value, 0);
    // 监听函数已立即触发，它修改了 activeCountWatch 变量
    expect(state.activeCountWatch, true);

    await tester.pumpWidget(_MainApp(
      state: state,
      child: const _StateTestWidget(),
    ));

    // 模拟反复销毁 count1-1 的 ObsBuilder，检测 count 依赖的构建函数集合是否正确
    expect(ObsTest.getBuilderFunLength(state.count), 2);
    await tester.tap(find.text('count1-1: 0'));
    await tester.pump();
    expect(state.activeCountWatch, true);
    expect(find.text('count1-1: 1'), findsOneWidget);
    expect(find.text('count1-2: 1'), findsOneWidget);
    expect(find.text('count2: 0'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(ObsTest.getBuilderFunLength(state.count), 1);

    await tester.tap(find.text('count2: 0'));
    await tester.pump();
    expect(find.text('count1-2: 1'), findsOneWidget);
    expect(find.text('count2: 1'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(ObsTest.getBuilderFunLength(state.count), 2);

    await tester.tap(find.text('count1-1: 1'));
    await tester.pump();
    expect(find.text('count1-1: 2'), findsOneWidget);
    expect(find.text('count1-2: 2'), findsOneWidget);
    expect(find.text('count2: 1'), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(ObsTest.getBuilderFunLength(state.count), 1);

    // 进入子页面会绑定1000个响应式构建器，所以 Obs 注册的依赖长度要为1001
    await tester.tap(find.text('child page'));
    await tester.pumpAndSettle();
    expect(ObsTest.getWatchFunLength(state.count), 1);
    expect(ObsTest.getBuilderFunLength(state.count2), 1001);
    // 重置响应式变量，count2预期值要为0
    await tester.tap(find.text('reset count2'));
    await tester.pumpAndSettle();
    expect(find.text('child-count2: 0'), findsWidgets);
    // 返回页面，需要自动销毁1000个依赖，count2的依赖预期值要为1
    await tester.tap(find.text('back'));
    await tester.pumpAndSettle();
    expect(ObsTest.getWatchFunLength(state.count), 0);
    expect(ObsTest.getBuilderFunLength(state.count2), 1);

    // 一旦此变量被销毁，则不可再使用，这是 ChangeNotifier 的机制，所以下方代码需要注释掉
    state.count2.dispose();
    await tester.pumpAndSettle();
    expect(find.text('count2: 0'), findsOneWidget);
    // await tester.tap(find.text('count2: 0'));
    // await tester.pumpAndSettle();
    // expect(find.text('count2: 1'), findsOneWidget);

    // 被销毁的变量可以重新赋值，然后继续使用
    state.count2 = Obs(10);
    await tester.tap(find.byType(Switch)); // 更新 switch 让页面刷新
    await tester.pumpAndSettle();
    await tester.tap(find.text('count2: 10'));
    await tester.pumpAndSettle();
    expect(find.text('count2: 11'), findsOneWidget);
  });
}

class GlobalState {
  bool activeCountWatch = false;

  GlobalState(this.immediate);

  /// 是否立即运行一次 count 监听函数，count 使用 late 修饰，
  /// 想要生效必须先访问一次 count
  final bool immediate;

  late final count = Obs(
    0,
    immediate: immediate,
    watch: (newValue, oldValue) {
      activeCountWatch = true;
    },
  );
  var count2 = Obs(0);
}

class _MainApp extends StatelessWidget {
  const _MainApp({required this.state, required this.child});

  final GlobalState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _StateProvider(
      state,
      child: MaterialApp(
        home: Material(
          child: child,
        ),
      ),
    );
  }
}

class _StateProvider extends InheritedWidget {
  const _StateProvider(
    this.state, {
    required super.child,
  });

  final GlobalState state;

  static _StateProvider of(BuildContext context) {
    final _StateProvider? result =
        context.dependOnInheritedWidgetOfExactType<_StateProvider>();
    assert(result != null, 'No _StateProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_StateProvider oldWidget) => true;
}

class _NestBuilder extends StatefulWidget {
  const _NestBuilder();

  @override
  State<_NestBuilder> createState() => _NestBuilderState();
}

class _NestBuilderState extends State<_NestBuilder> {
  int parentUpdateCount = -1;
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    final state = _StateProvider.of(context).state;
    return Column(
      children: [
        ObsBuilder(builder: (context) {
          parentUpdateCount++;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Switch(
                value: flag,
                onChanged: (v) => setState(() {
                  flag = v;
                }),
              ),
              ElevatedButton(
                onPressed: () {
                  state.count.value++;
                },
                // 不要出现这种写法，这会导致 count 变量持续依赖外部 ObsBuilder
                child: flag
                    ? ObsBuilder(builder: (context) {
                        return Text('count1: ${state.count.value}');
                      })
                    : Text('count1: ${state.count.value}'),
              ),
              Text('parentUpdateCount: $parentUpdateCount'),
              ElevatedButton(
                onPressed: () {
                  state.count2.value++;
                },
                child: Text('count2: ${state.count2.value}'),
              ),
            ],
          );
        }),
      ],
    );
  }
}

class _StateTestWidget extends StatefulWidget {
  const _StateTestWidget();

  @override
  State<_StateTestWidget> createState() => _StateTestWidgetState();
}

class _StateTestWidgetState extends State<_StateTestWidget> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    final state = _StateProvider.of(context).state;

    return Column(
      children: [
        Switch(
          value: flag,
          onChanged: (v) => setState(() {
            flag = v;
          }),
        ),
        ObsBuilder(builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (flag)
                ElevatedButton(
                  onPressed: () {
                    state.count.value++;
                  },
                  child: ObsBuilder(builder: (context) {
                    return Text('count1-1: ${state.count.value}');
                  }),
                ),
              ElevatedButton(
                onPressed: () {
                  state.count.value++;
                },
                child: Text('count1-2: ${state.count.value}'),
              ),
              ElevatedButton(
                onPressed: () {
                  state.count2.value++;
                },
                child: Text('count2: ${state.count2.value}'),
              ),
            ],
          );
        }),
        ElevatedButton(
          onPressed: () async {
            await push(context, const _ChildPage());
            // state.count2.dispose();
          },
          child: const Text('child page'),
        ),
      ],
    );
  }
}

class _ChildPage extends StatefulWidget {
  const _ChildPage();

  @override
  State<_ChildPage> createState() => _ChildPageState();
}

class _ChildPageState extends State<_ChildPage> {
  late GlobalState state;

  @override
  void dispose() {
    super.dispose();
    state.count.removeWatch(countWatch);
  }

  void countWatch(newValue, oldValue) {}

  @override
  Widget build(BuildContext context) {
    state = _StateProvider.of(context).state;
    // 会忽略重复添加的相同监听函数
    state.count.addWatch(countWatch);
    state.count.addWatch(countWatch);
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                state.count2.reset();
              },
              child: const Text('reset count2'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('back'),
            ),
            ...List.generate(
              1000,
              (index) => ObsBuilder(builder: (context) {
                return Text('child-count2: ${state.count2.value}');
              }),
            ),
          ],
        ),
      ),
    );
  }
}
