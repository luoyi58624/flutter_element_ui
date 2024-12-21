import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: const [
            _Example(),
          ],
        ),
      ],
    );
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            ElDragResizer(
              cacheKey: 'resizer_example1',
              initialPosition: Offset.zero,
              initialSize: const Size(100, 100),
              minSize: const Size(50, 50),
              maxSize: Size(constraints.maxWidth, constraints.maxHeight),
              child: ElEvent(
                child: Builder(builder: (context) {
                  return ColoredBox(
                    color: context.hasTap ? Colors.red : Colors.grey,
                  );
                }),
              ),
            ),
          ],
        );
      }),
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    // useState 会引起整个 build 重建，会不断触发下面 LayoutBuilder 的条件
    final left = useObs(100.0);

    return LayoutBuilder(builder: (context, constraints) {
      // 布局尺寸如果变小，那么需要同步分隔条的位置，防止溢出
      if (left.value > constraints.maxWidth) {
        nextTick(() => left.value = constraints.maxWidth);
      }

      return Container(
        height: 300,
        decoration: BoxDecoration(border: context.elBorder),
        child: ObsBuilder(builder: (context) {
          // 拖拽的实际位置肯定需要跟随指针，但显示在页面上的位置必须施加限制
          final double positionLeft =
              min(max(left.value, 0), constraints.maxWidth);

          return Stack(
            children: [
              Positioned(
                left: positionLeft,
                top: 0,
                bottom: 0,
                child: ElSplitResizerTheme(
                  data: const ElSplitResizerThemeData(
                    size: 1,
                  ),
                  child: ElSplitResizer(
                    onChanged: (double value) => left.value += value,
                    onEnd: () => left.value = positionLeft,
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}''';
