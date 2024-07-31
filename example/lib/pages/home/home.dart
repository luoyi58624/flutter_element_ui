import 'dart:math';

import 'package:example/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    final show = useState(true);
    final activeIndex = useState(0);
    final listData = useState([
      Container(
        width: 200,
        height: 100,
        color: Colors.green,
      ),
      // Container(
      //   width: 100,
      //   height: 100,
      //   color: Colors.red,
      // ),
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          if (context.sm)
            ObsBuilder(builder: (context) {
              return Switch(
                value: GlobalState.isDark.value,
                onChanged: (v) => GlobalState.isDark.value = v,
              );
            }),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElButton(
                onPressed: () {
                  count.value++;
                },
                child: 'count: ${count.value}',
              ),
              ElButton(
                onPressed: () {
                  listData.value = [
                    ...listData.value,
                    Container(
                      width: 300,
                      height: 200,
                      color: Colors.green,
                    )
                  ];
                  // show.value = !show.value;
                },
                child: '切换',
              ),
              // ...listData.value,
              ElCustomMultiChildLayout(
                height: 600,
                delegateBuilder: (updateSize) =>
                    _D(updateSize, listData.value.length),
                children: listData.value
                    .mapIndexed((i, e) => LayoutId(id: i, child: e))
                    .toList(),
              ),
              ElButton(
                onPressed: () {
                  if (listData.value.isEmpty) return;
                  listData.value =
                      listData.value.sublist(0, listData.value.length - 1);
                  // show.value = !show.value;
                },
                child: '切换',
              ),
              // const Gap(8),
              // _Box(
              //   color: show.value ? Colors.red : Colors.blue,
              // ),

              // HoverBuilder(builder: (context) {
              //   return const Text('hello')
              //       .animate(target: show.value ? 1 : 0)
              //       .fade(duration: 200.ms);
              // }),
              // const Gap(50),
              // TapBuilder(builder: (context) {
              //   return Container(
              //     width: 100,
              //     height: 100,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ).animate(target: context ? 1 : 0).scale(
              //         duration: 200.ms,
              //         curve: Curves.easeOut,
              //         begin: const Offset(1.0, 1.0),
              //         end: const Offset(0.9, 0.9),
              //       );
              // }),
            ],
          ),
        ),
      ),
    );
  }
}

class _D extends MultiChildLayoutDelegate {
  final ElUpdateSizeCallback updateSize;
  final int length;

  _D(this.updateSize, this.length);

  @override
  void performLayout(Size size) {
    double parentHeight = 0;
    for (int i = 0; i < length; i++) {
      final currentSize = layoutChild(
          i,
          const BoxConstraints(
            minHeight: 0,
            maxHeight: 600,
          ));
      positionChild(i, Offset(0, parentHeight));
      if (i == length - 1) {
        e(size);
        e(currentSize.height);
      }
      parentHeight += currentSize.height + 8;
    }
    // i(parentHeight);
    updateSize(Size(double.infinity, parentHeight));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}

class _Box extends LeafRenderObjectWidget {
  final Color color;

  const _Box({required this.color});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BoxRender(color);
  }

  @override
  void updateRenderObject(BuildContext context, _BoxRender renderObject) {
    renderObject.color = color;
  }
}

class _BoxRender extends RenderBox {
  _BoxRender(this.color);

  Color color;

  @override
  void paint(PaintingContext context, Offset offset) {
    i('paint', offset);
    final w = size.width;
    final h = size.height;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    // final path = Path()
    //   ..moveTo(0, h)
    //   ..lineTo(w / 2, 0)
    //   ..lineTo(w, h);
    // context.canvas.clipPath(path);
    context.canvas.drawRect(offset & size, paint);
  }

  @override
  void performLayout() {
    i('per');
    size = const Size(50, 50);
  }
}
