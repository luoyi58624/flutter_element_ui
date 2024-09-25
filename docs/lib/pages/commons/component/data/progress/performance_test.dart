import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class PerformanceTestPage extends HookWidget {
  const PerformanceTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('进度条性能测试'),
        actions: [
          ElText(flag.value ? 'Flutter' : 'Element'),
          const Gap(8),
          Switch(
            value: flag.value,
            onChanged: (v) => flag.value = v,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: flag.value ? const _Left() : const _Right(),
        ),
      ),
    );
  }
}

class _Left extends HookWidget {
  const _Left();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        1000,
        (index) => Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              ElText('${index + 1}. '),
              const Expanded(child: LinearProgressIndicator()),
            ],
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
    return Column(
      children: List.generate(
        1000,
        (index) => Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              ElText('${index + 1}. '),
              const Expanded(
                child: ElProgress.animate(
                  50,
                  duration: Duration(milliseconds: 2000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
