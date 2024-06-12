import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, addCount) = useCount();
    final (flag, toggle) = useToggle(true);
    return SelectionArea(
      child: Builder(builder: (context) {
        return Material(
          textStyle: TextStyle(fontFamily: FontUtil.fontFamily),
          child: Column(
            children: [
              const Gap(16),
              const Center(child: ElText('hello, world')),
              const Center(child: ElText('你好，世界')),
              const Text('text'),
              ElButton('count: $count', onPressed: addCount),
              UnconstrainedBox(child: Switch(value: flag, onChanged: toggle)),
              Expanded(
                child: SuperListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) =>
                      flag ? const _Button('x2xx') : const _Button2(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _Button extends HookWidget {
  const _Button(this.demo);

  final String demo;

  @override
  Widget build(BuildContext context) {
    final (count, addCount) = useCount();
    return Wrap(
      children: [
        ElButton('Default: $count', type: 'primary', onPressed: addCount),
        ElButton('Default: $count', onPressed: addCount),
      ],
    );
  }
}

class _Button2 extends HookWidget {
  const _Button2();

  @override
  Widget build(BuildContext context) {
    final (count, addCount) = useCount();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          // ElevatedButtonTheme(
          //   data: ElevatedButtonThemeData(
          //     style: ButtonStyle(
          //       shape: WidgetStatePropertyAll(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(4),
          //         ),
          //       ),
          //     ),
          //   ),
          //   child: ElevatedButton(onPressed: addCount, child: Text('Default: $count')),
          // ),
          ElevatedButton(onPressed: addCount, child: Text('Default: $count')),
          ElevatedButton(onPressed: addCount, child: Text('Default: $count')),
        ],
      ),
    );
  }
}
