import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, addCount) = useCount();
    final (flag, toggle) = useToggle(true);
    return Builder(builder: (context) {
      return Material(
        child: Column(
          children: [
            ElButton(child: 'count: $count', onPressed: addCount),
            ElButton(
              child: 'count: $count',
              onPressed: addCount,
              type: 'primary',
            ),
            SelectionArea(
              child: Column(
                children: [
                  ElButton(child: 'count: $count', onPressed: addCount),
                  ElButton(
                    child: 'count: $count',
                    onPressed: addCount,
                    type: 'primary',
                  ),
                ],
              ),
            ),
            UnconstrainedBox(child: Switch(value: flag, onChanged: toggle)),
            Expanded(
              child: SuperListView.builder(
                itemCount: 100000,
                itemBuilder: (context, index) =>
                    flag ? _Button('x2xx', index) : const _Button2(),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _Button extends HookWidget {
  const _Button(this.demo, this.index);

  final String demo;
  final int index;

  @override
  Widget build(BuildContext context) {
    final (count, addCount) = useCount();
    return Wrap(
      children: [
        ElButton(
            child: '$index - Default: $count', type: 'primary', onPressed: addCount),
        ElButton(child: 'Default: $count', onPressed: addCount),
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
