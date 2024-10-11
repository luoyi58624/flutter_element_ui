import 'package:example/global.dart';
import 'package:flutter/material.dart';

class TextScrollTestPage extends HookWidget {
  const TextScrollTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text 文本滚动性能测试'),
        actions: [
          ElText(flag.value ? '虚拟滚动' : '普通滚动'),
          const Gap(8),
          Switch(
            value: flag.value,
            onChanged: (v) => flag.value = v,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(child: _Text(flag.value)),
            Expanded(child: _ElText(flag.value)),
          ],
        ),
      ),
    );
  }
}

class _Text extends HookWidget {
  const _Text(this.virtualScroll);

  final bool virtualScroll;

  @override
  Widget build(BuildContext context) {
    return virtualScroll
        ? SuperListView.builder(
            itemCount: 10000,
            itemBuilder: (context, index) => Text('Text - ${index + 1}'),
          )
        : ColumnWidget(
            scroll: true,
            children: List.generate(
              1000,
              (index) => Text('Text - ${index + 1}'),
            ),
          );
  }
}

class _ElText extends HookWidget {
  const _ElText(this.virtualScroll);

  final bool virtualScroll;

  @override
  Widget build(BuildContext context) {
    return virtualScroll
        ? SuperListView.builder(
            itemCount: 10000,
            itemBuilder: (context, index) => ElText('ElText - ${index + 1}'),
          )
        : ColumnWidget(
            scroll: true,
            children: List.generate(
              1000,
              (index) => ElText('ElText - ${index + 1}'),
            ),
          );
  }
}
