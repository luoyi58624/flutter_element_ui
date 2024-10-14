import 'dart:ui';

import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TempTestPage extends HookWidget {
  const TempTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('临时测试页面'),
      ),
      body: const Demo3(),
    );
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  late List<int> list = List.generate(20, (index) => index);

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 8, animValue)!;
        return Material(
          elevation: elevation,
          borderRadius: BorderRadius.circular(10),
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        var child = list.removeAt(oldIndex);
        list.insert(newIndex, child);
        setState(() {});
      },
      itemCount: list.length,
      proxyDecorator: _proxyDecorator,
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemBuilder: (context, index) => _DragStartListener(
        key: ValueKey(list[index]),
        index: list[index],
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.primaries[index % Colors.primaries.length],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class _DragStartListener extends ReorderableDragStartListener {
  const _DragStartListener({
    super.key,
    required super.child,
    required super.index,
    super.enabled,
  });

  @override
  MultiDragGestureRecognizer createRecognizer() {
    return DelayedMultiDragGestureRecognizer(debugOwner: this, delay: 100.ms);
  }
}

class _Demo2 extends HookWidget {
  const _Demo2({super.key});

  @override
  Widget build(BuildContext context) {
    final activeIndex = useState(0);
    return Row(
      children: [
        ...List.generate(
          10,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTapDown: (e) {
                activeIndex.value = index;
              },
              child: LongPressDraggable(
                onDragUpdate: (e) {
                  i(e.delta.dx);
                },
                delay: 50.ms,
                feedback: Container(
                  width: 100,
                  height: 44,
                  color: Colors.green,
                ),
                child: Container(
                  width: 100,
                  height: 44,
                  decoration: BoxDecoration(
                    color: activeIndex.value == index ? Colors.red : null,
                    border: Border.all(color: context.elTheme.colors.border),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Demo3 extends StatefulWidget {
  const Demo3({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  State<Demo3> createState() => _Demo3State();
}

class _Demo3State extends State<Demo3> {
  final List<int> _items = List<int>.generate(1000, (int index) => index);

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final List<Card> cards = <Card>[
      for (int index = 0; index < _items.length; index += 1)
        Card(
          key: Key('$index'),
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.primaries[_items[index] % Colors.primaries.length],
          child: SizedBox(
            width: 100,
            child: Center(
              child: Text('Card ${_items[index]}'),
            ),
          ),
        ),
    ];

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double scale = lerpDouble(1, 1.15, animValue)!;
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: child,
      );
    }

    return SizedBox(
      height: 50,
      child: CupertinoScrollbar(
        controller: controller,
        child: ReorderableListView(
          scrollController: controller,
          buildDefaultDragHandles: false,
          scrollDirection: Axis.horizontal,
          // padding: const EdgeInsets.symmetric(horizontal: 8),
          proxyDecorator: proxyDecorator,
          shrinkWrap: true,
          autoScrollerVelocityScalar: 500,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final int item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });
          },
          children: cards
              .mapIndexed(
                (i, e) => _DragStartListener(
                  key: ValueKey(cards[i]),
                  index: i,
                  child: e,
                ),
              )
              .toList(),
        ).noScrollBehavior,
      ),
    );
  }
}
