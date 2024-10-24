import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class PerformanceTestPage extends HookWidget {
  const PerformanceTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('100 个按钮组性能测试'),
        actions: [
          ElText(flag.value ? 'Flutter' : 'Element'),
          const Gap(8),
          Switch(
            value: flag.value,
            onChanged: (v) => flag.value = v,
          ),
        ],
      ),
      body: flag.value ? const _Left() : const _Right(),
    );
  }
}

class _Left extends HookWidget {
  const _Left();

  @override
  Widget build(BuildContext context) {
    final selected = useState({0});
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: List.generate(
              100,
              (index) => SegmentedButton<int>(
                segments: const <ButtonSegment<int>>[
                  ButtonSegment(value: 0, label: Text('选项一')),
                  ButtonSegment(value: 1, label: Text('选项二')),
                  ButtonSegment(value: 2, label: Text('选项三')),
                ],
                selected: selected.value,
                onSelectionChanged: (v) {
                  selected.value = v;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Right extends HookWidget {
  const _Right();

  @override
  Widget build(BuildContext context) {
    final selected = useState(0);
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: List.generate(
              100,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ElButtonTheme.merge(
                  data: const ElButtonThemeData(
                    type: El.primary,
                  ),
                  child: ElButtonGroup.single(
                    selected,
                    children: const [
                      ElButton(child: '选项一'),
                      ElButton(child: '选项二'),
                      ElButton(child: '选项三'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
