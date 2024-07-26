import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: SelectionArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElText(
                  ElButton(
                    onPressed: () {},
                    child: const Text('Element UI Text'),
                  ),
                ),
                const _RichText(),
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

class _RichText extends StatefulWidget {
  const _RichText({super.key});

  @override
  State<_RichText> createState() => _RichTextState();
}

class _RichTextState extends State<_RichText> {
  bool flag1 = false;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          const TextSpan(text: 'xxx'),
          TextSpan(
            text: 'xxx',
            onEnter: (e) {
              setState(() {
                flag1 = true;
              });
            },
            onExit: (e) {
              setState(() {
                flag1 = false;
              });
            },
            mouseCursor: SystemMouseCursors.click,
            style: TextStyle(color: flag1 ? Colors.red : Colors.green),
          ),
          const WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Text('xxx'),
          ),
          const WidgetSpan(child: Text('xxx')),
        ],
      ),
    );
  }
}
