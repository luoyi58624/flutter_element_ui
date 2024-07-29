import 'dart:math';

import 'package:example/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final show = useState(true);
    final activeIndex = useState(0);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Tab(
              activeIndex,
              children: [
                ...List.generate(
                  10,
                  (index) => const _TabItem(),
                )
              ],
            ),
            // ElButton(
            //   onPressed: () {
            //     show.value = !show.value;
            //   },
            //   child: '切换',
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
    );
  }
}

class _Box extends LeafRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BoxRender();
  }
}

class _BoxRender extends RenderBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.lightBlue;
    context.canvas.drawRect(offset & const Size(100, 100), paint);
  }

  @override
  void performLayout() {
    size = const Size(100, 200);
  }
}

class _TabData extends InheritedWidget {
  const _TabData(
    this.modelValue,
    this.height,
    this.radius, {
    required super.child,
  });

  final ValueNotifier<int> modelValue;
  final double height;
  final double radius;

  static _TabData of(BuildContext context) {
    final _TabData? result =
        context.dependOnInheritedWidgetOfExactType<_TabData>();
    assert(result != null, 'No _TabData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_TabData oldWidget) => true;
}

class _Tab extends HookWidget {
  const _Tab(this.modelValue, {required this.children});

  final ValueNotifier<int> modelValue;
  final List<_TabItem> children;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    const width = 200.0;
    const height = 36.0;
    double radius = height / 4 * 3;
    double maxWidth = width + (width - radius) * (children.length - 1);
    return _TabData(
      modelValue,
      height,
      radius,
      child: Listener(
        onPointerSignal: (e) {
          if (e is PointerScrollEvent) {
            scrollController.jumpTo(
              min(
                max(0, scrollController.offset + e.scrollDelta.dy),
                maxWidth - context.size!.width,
              ),
              // duration: const Duration(milliseconds: 100),
              // curve: Curves.ease,
            );
          }
        },
        child: ScrollConfiguration(
          behavior: const NoScrollBehavior(),
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Container(
              width: maxWidth,
              height: 40,
              padding: const EdgeInsets.only(top: 4),
              color: Colors.grey.shade300,
              // child: Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     ...children.mapIndexed(
              //       (i, e) => ElChildIndexData(
              //         index: i,
              //         child: e,
              //       ),
              //     ),
              //   ],
              // ),
              child: CustomMultiChildLayout(
                delegate: _Delegate(children.length, radius),
                children: [
                  ...children.mapIndexed(
                    (i, e) => ElChildIndexData(
                      index: i,
                      child: LayoutId(
                        id: i,
                        child: ClipPath(
                          clipper: _Clipper(radius),
                          child: e,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem();

  @override
  Widget build(BuildContext context) {
    final $data = _TabData.of(context);
    final $indexData = ElChildIndexData.of(context);

    return Draggable(
      feedback: Container(
        width: 200,
        height: 40,
        color: Colors.green,
      ),
      child: GestureDetector(
        onTapDown: (e) {
          $data.modelValue.value = $indexData.index;
        },
        child: HoverBuilder(builder: (context) {
          return Builder(
            builder: (context) => Container(
              width: 200,
              height: $data.height,
              padding: EdgeInsets.symmetric(horizontal: $data.radius),
              color: $data.modelValue.value == $indexData.index
                  ? Colors.white
                  : HoverBuilder.of(context)
                      ? Colors.grey.shade100
                      : null,
              child: Row(
                children: [
                  Text(
                    '标签页 - ${$indexData.index + 1}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _Delegate extends MultiChildLayoutDelegate {
  final int length;
  final double r;

  _Delegate(this.length, this.r);

  @override
  void performLayout(Size size) {
    if (length == 0) return;
    Size preSize = layoutChild(0, BoxConstraints.loose(size));
    for (int i = 1; i < length; i++) {
      final currentSize = layoutChild(i, BoxConstraints.loose(size));
      positionChild(i, Offset((preSize.width - r) * i, 0));
      preSize = currentSize;
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}

class _Clipper extends CustomClipper<Path> {
  final double r;

  _Clipper(this.r);

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();
    path.moveTo(0, h);
    path.cubicTo(r, h, 0, 0, r, 0);
    path.lineTo(w - r, 0);
    path.cubicTo(w, 0, w - r, h, w, h);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}
