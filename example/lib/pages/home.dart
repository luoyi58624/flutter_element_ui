import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final (count, addCount) = useCount();
    final (flag, toggle) = useToggle(true);
    final controller = useScrollController();
    return SelectionArea(
      child: Builder(builder: (context) {
        return Material(
          child: ElScrollbar(
              controller: controller,
              child: ListView(
                controller: controller,
                children: [
                  const Gap(16),
                  const Center(child: ElText('hello, world')),
                  // const Center(child: ElText('你好，世界')),
                  const Text('text'),
                  const Gap(16),
                  ElButton('count: $count', onPressed: addCount),
                  UnconstrainedBox(child: Switch(value: flag, onChanged: toggle)),
                  ...List.generate(1000, (index) => flag ? const _Button() : const _Button2()),
                ],
              )),
        );
      }),
    );
  }
}

class _Button extends HookWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    final (count, addCount) = useCount();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ElButtonImportantTheme(
            style: const ElButtonStyle(
              type: ElThemeType.error,
              plain: true,
            ),
            child: ElButton('Default: $count', onPressed: addCount),
          ),
          ElTextImportantTheme(
            style: const ElTextStyle(
              textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            child: ElButton(
              'Primary: $count',
              onPressed: addCount,
              style: const ElButtonStyle(type: ElThemeType.primary),
            ),
          ),
          ElButton(
            'Success: $count',
            onPressed: addCount,
            style: const ElButtonStyle(type: ElThemeType.success),
          ),
          ElButton(
            'Info: $count',
            onPressed: addCount,
            style: const ElButtonStyle(type: ElThemeType.info),
          ),
          ElButton(
            'Warning: $count',
            onPressed: addCount,
            style: const ElButtonStyle(type: ElThemeType.warning),
          ),
          ElButton(
            'Error: $count',
            onPressed: addCount,
            style: const ElButtonStyle(type: ElThemeType.error),
          ),
        ],
      ),
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
          ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            child: ElevatedButton(onPressed: addCount, child: Text('Default: $count')),
          ),
          TextButton(onPressed: addCount, child: Text('Default: $count')),
          FilledButton(onPressed: addCount, child: Text('Default: $count')),
          CupertinoButton.filled(onPressed: addCount, child: Text('Default: $count')),
          ElevatedButton(onPressed: addCount, child: Text('Default: $count')),
          FilledButton(onPressed: addCount, child: Text('Default: $count')),
        ],
      ),
    );
  }
}
