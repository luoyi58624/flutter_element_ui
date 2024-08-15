import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchPage extends HookWidget {
  const SwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    final disabled = useState(true);
    const count = 100;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Row(
          children: [
            Column(
              children: [
                ElSwitch(flag),
                const Gap(8),
                ElSwitch(flag, width: 100),
                const Gap(8),
                ElSwitch(flag, gap: 8),
                const Gap(8),
                ElSwitch(disabled),
                const Gap(8),
                ElSwitch(flag, disabled: disabled.value),
              ],
            ),
            const _SwitchTest1(count),
            const _SwitchTest2(count),
            const _SwitchTest3(count),
          ],
        ),
      ),
    );
  }
}

class _SwitchTest1 extends HookWidget {
  const _SwitchTest1(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    final flag = useState(true);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ...List.generate(
              count,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElSwitch(flag),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTest2 extends HookWidget {
  const _SwitchTest2(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    final flag = useState(true);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ...List.generate(
              count,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch(
                  value: flag.value,
                  onChanged: (v) => flag.value = v,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTest3 extends HookWidget {
  const _SwitchTest3(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    final flag = useState(true);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ...List.generate(
              count,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSwitch(
                  value: flag.value,
                  onChanged: (v) => flag.value = v,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
