import 'dart:ui';

import 'package:element_docs/global.dart';
import 'package:element_docs/pages/test/friction_animate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TempTestPage extends HookWidget {
  const TempTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('临时测试页面'),
        actions: [
          ObsBuilder(builder: (context) {
            return ElSwitch(
              GlobalState.isDark,
              onChanged: (v) => GlobalState.isDark = v,
            );
          }),
          const Gap(8),
        ],
      ),
      body: FrictionAnimateTest(),
      // body: const Demo3(),
      // body: Demo(
      //   flag: flag.value,
      // ),
    );
  }
}

class Demo extends StatelessWidget {
  const Demo({super.key, required this.flag});

  final bool flag;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: flag
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      children: List.generate(
        100,
        (index) => ListTile(
          title: Text('Item - ${index + 1}'),
        ),
      ),
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
      child: HorizontalScrollWidget(
        controller: controller,
        child: ReorderableListView(
          scrollController: controller,
          buildDefaultDragHandles: false,
          scrollDirection: Axis.horizontal,
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
                (i, e) => DragStartListener(
                  key: ValueKey(cards[i]),
                  index: i,
                  child: e,
                ),
              )
              .toList(),
        ).cupertinoScrollBehavior,
      ),
    );
  }
}

extension FlutterWidgetExtension on Widget {
  Widget get cupertinoScrollBehavior => ScrollConfiguration(
    behavior: const CupertinoScrollBehavior(),
    child: this,
  );
}

class CupertinoScrollBehavior extends CustomScrollBehavior {
  const CupertinoScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) {
    return CupertinoScrollbar(
      controller: details.controller,
      child: child,
    );
  }
}