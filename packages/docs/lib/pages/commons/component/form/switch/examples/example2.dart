import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: const [
            _SwitchExample(),
          ],
        ),
      ],
    );
  }
}

class _SwitchExample extends HookWidget {
  const _SwitchExample();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // size 属性可以控制开关大小
        Row(
          children: [
            ElSwitch(flag, size: 20),
            const Gap(8),
            ElSwitch(flag),
            const Gap(8),
            ElSwitch(flag, size: 28),
          ],
        ),
        // gap 属性可以控制开关与外部之间的间距
        Row(
          children: [
            ElSwitch(flag),
            const Gap(8),
            ElSwitch(flag, gap: 6),
            const Gap(8),
            ElSwitch(flag, gap: 12),
          ],
        ),
        // width 属性可以控制开关整体宽度
        Row(
          children: [
            ElSwitch(flag, width: 60),
            const Gap(8),
            ElSwitch(flag, width: 80),
            const Gap(8),
            ElSwitch(flag, width: 100),
          ],
        ),
      ],
    );
  }
}

String get code => '''
class _SwitchExample extends HookWidget {
  const _SwitchExample();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // size 属性可以控制开关大小
        Row(
          children: [
            ElSwitch(flag, size: 20),
            const Gap(8),
            ElSwitch(flag),
            const Gap(8),
            ElSwitch(flag, size: 28),
          ],
        ),
        // gap 属性可以控制开关与容器之间的间距
        Row(
          children: [
            ElSwitch(flag),
            const Gap(8),
            ElSwitch(flag, gap: 6),
            const Gap(8),
            ElSwitch(flag, gap: 12),
          ],
        ),
        // width 属性可以控制开关整体宽度
        Row(
          children: [
            ElSwitch(flag, width: 60),
            const Gap(8),
            ElSwitch(flag, width: 80),
            const Gap(8),
            ElSwitch(flag, width: 100),
          ],
        ),
      ],
    );
  }
}''';
