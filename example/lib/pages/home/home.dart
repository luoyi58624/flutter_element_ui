import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String code = """
ElButton(onPressed: () {}, child: 'Default'),
ElButton(onPressed: () {}, type: 'primary', child: 'Primary'),
ElButton(onPressed: () {}, type: 'success', child: 'Success'),""";
    final show = useState(true);
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ElButton(onPressed: () {}, child: 'Default'),
                  ElButton(onPressed: () {}, type: 'primary', child: 'Primary'),
                  ElButton(onPressed: () {}, type: 'success', child: 'Success'),
                ],
              ),
              SelectionArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        code,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [],
                  ),
                ),
              ),
              // ElButton(
              //   onPressed: () {
              //     show.value = !show.value;
              //   },
              //   child: '切换',
              // ),
              // ElHover(builder: (isHover) {
              //   return const Text('hello')
              //       .animate(target: show.value ? 1 : 0)
              //       .fade(duration: 200.ms);
              // }),
              // const Gap(50),
              // ElTap(builder: (isTap) {
              //   return Container(
              //     width: 100,
              //     height: 100,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ).animate(target: isTap ? 1 : 0).scale(
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
