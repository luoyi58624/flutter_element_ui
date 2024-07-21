import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = TinyColor.fromColor(context.elTheme.primary).color;
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElButton(
                onPressed: () {
                  show.value = !show.value;
                },
                child: '切换',
              ),
              ElHover(builder: (isHover) {
                return const Text('hello')
                    .animate(target: show.value ? 1 : 0)
                    .fade(duration: 200.ms);
              }),
              const Gap(50),
              ElTap(builder: (isTap) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ).animate(target: isTap ? 1 : 0).scale(
                      duration: 200.ms,
                      curve: Curves.easeOut,
                      begin: const Offset(1.0, 1.0),
                      end: const Offset(0.9, 0.9),
                    );
              }),
              Text(primaryColor.toHex()),
              Text(TinyColor.fromColor(Colors.white)
                  .mix(primaryColor, 10)
                  .toColor()
                  .toHex()),
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
