import 'package:flutter/material.dart';
import 'package:example/global.dart';

import 'common.dart';

class ButtonWidgets extends HookWidget {
  const ButtonWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    final selects = useState({0});
    return ComponentDecoration(title: 'Buttons', children: [
      RowCell(
        children: [
          ElevatedButton(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          const Gap(10),
          ElevatedButton.icon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          const Gap(10),
          ElevatedButton(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      RowCell(
        children: [
          FilledButton(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          const Gap(10),
          FilledButton.icon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          const Gap(10),
          FilledButton(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      RowCell(
        children: [
          FilledButton.tonal(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          const Gap(10),
          FilledButton.tonalIcon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          const Gap(10),
          FilledButton.tonal(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      RowCell(
        children: [
          OutlinedButton(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          const Gap(10),
          OutlinedButton.icon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          const Gap(10),
          OutlinedButton(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      RowCell(
        children: [
          TextButton(
            onPressed: () => count.value++,
            child: Text('count: ${count.value}'),
          ),
          const Gap(10),
          TextButton.icon(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          const Gap(10),
          TextButton(
            onPressed: null,
            child: Text('count: ${count.value}'),
          ),
        ],
      ),
      RowCell(
        children: [
          IconButton(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
          ),
          const Gap(10),
          IconButton.filled(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
          ),
          const Gap(10),
          IconButton.filledTonal(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
          ),
          const Gap(10),
          IconButton.outlined(
            onPressed: () => count.value++,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      const RowCell(
        children: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
          Gap(10),
          IconButton.filled(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
          Gap(10),
          IconButton.filledTonal(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
          Gap(10),
          IconButton.outlined(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      RowCell(
        children: [
          FloatingActionButton(
            onPressed: () => count.value++,
            heroTag: null,
            child: const Icon(Icons.add),
          ),
          const Gap(10),
          FloatingActionButton.extended(
            onPressed: () => count.value++,
            heroTag: null,
            icon: const Icon(Icons.add),
            label: Text('count: ${count.value}'),
          ),
          const Gap(10),
          FloatingActionButton.small(
            onPressed: () => count.value++,
            heroTag: null,
            child: const Icon(Icons.add),
          ),
          const Gap(10),
          FloatingActionButton.large(
            onPressed: () => count.value++,
            heroTag: null,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      const Gap(16),
      SegmentedButton<int>(
        segments: const <ButtonSegment<int>>[
          ButtonSegment(
              value: 0,
              label: Text('选项一'),
              icon: Icon(Icons.calendar_view_day)),
          ButtonSegment(
              value: 1,
              label: Text('选项二'),
              icon: Icon(Icons.calendar_view_week)),
          ButtonSegment(
              value: 2,
              label: Text('选项三'),
              icon: Icon(Icons.calendar_view_month)),
        ],
        selected: selects.value,
        onSelectionChanged: (v) {
          selects.value = v;
        },
      ),
      const Gap(16),
      SegmentedButton<int>(
        segments: const <ButtonSegment<int>>[
          ButtonSegment(value: 0, label: Text('选项一')),
          ButtonSegment(value: 1, label: Text('选项二')),
          ButtonSegment(value: 2, label: Text('选项三')),
        ],
        selected: selects.value,
        onSelectionChanged: (v) {
          selects.value = v;
        },
      ),
    ]);
  }
}
