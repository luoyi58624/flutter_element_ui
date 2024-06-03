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
        always: true,
        thumbColor: Colors.red,
        child: SingleChildScrollView(
          controller: controller,
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(value: flag, onChanged: toggle),
                ...List.generate(10, (index) => flag ? _Button() : _Button2()),
                // ...List.generate(100, (index) => const Text('text')),
              ],
            ),
          ),
        ),
      ),
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
          ElButton2('Default: $count', onClick: addCount),
          ElButton2('Primary: $count', type: ElThemeType.primary, onClick: addCount),
          ElButton2('Success: $count', type: ElThemeType.success, onClick: addCount),
          ElButton2('Info: $count', type: ElThemeType.info, onClick: addCount),
          ElButton2('Warning: $count', type: ElThemeType.warning, onClick: addCount),
          ElButton2('Error: $count', type: ElThemeType.error, onClick: addCount),
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
