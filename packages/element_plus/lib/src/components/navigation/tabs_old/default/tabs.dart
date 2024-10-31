import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../base.dart';

class ElTabs2 extends ElBaseTabs {
  const ElTabs2(
    super.modelValue, {
    super.key,
    required super.children,
    super.height = 40,
    super.fontSize = 13,
    super.childMaxWidth = 200,
    super.bgColor,
    super.enabledAnimate,
    super.duration,
    super.curve,
  });

  @override
  State<ElTabs2> createState() => _ElTabsState();
}

class _ElTabsState extends ElBaseTabsState<ElTabs2> {
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        ..._items.mapIndexed(
          (i, e) => Container(
            key: Key('$i'),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            margin: const EdgeInsets.all(4),
            child: Text('Item ${_items[i]}'),
          ),
        ),
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final int item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
  }

  @override
  Widget buildTabs(BuildContext context) {
    // TODO: implement buildTabs
    throw UnimplementedError();
  }
}
