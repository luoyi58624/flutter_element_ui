import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final (flag, toggle) = useToggle(true);
    final controller = useScrollController();
    return Material(
      child: ElScrollbar(
          controller: controller,
          child: ListView(
            controller: controller,
            children: [
              Switch(value: flag, onChanged: toggle),
              ...List.generate(500, (index) => flag ? const _Button() : const _Button2()),
            ],
          )),
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
          ElButton('Default: $count', onClick: addCount),
          ElButton(
            'Primary: $count',
            onClick: addCount,
            style: const ElButtonStyle(type: ElThemeType.primary),
          ),
          ElButton(
            'Success: $count',
            onClick: addCount,
            style: const ElButtonStyle(type: ElThemeType.success),
          ),
          ElButton(
            'Info: $count',
            onClick: addCount,
            style: const ElButtonStyle(type: ElThemeType.info),
          ),
          ElButton(
            'Warning: $count',
            onClick: addCount,
            style: const ElButtonStyle(type: ElThemeType.warning),
          ),
          ElButton(
            'Error: $count',
            onClick: addCount,
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
