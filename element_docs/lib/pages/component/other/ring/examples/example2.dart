import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example2 extends HookWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: ['ElRing 属于隐式动画小部件，更改任意属性都会自动进行线性插值'],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [
            Row(
              children: [
                _Example(),
              ],
            ),
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
    final radius = useState(0.0);
    final isActive = useState(false);

    // ElRing 会自动计算圆角，所以你传递给 ElRing 的圆角值只需要和容器一致就行
    final borderRadius = BorderRadius.circular(radius.value);
    return Column(
      children: [
        Slider(
          min: 0,
          max: 50,
          label: radius.value.round().toString(),
          value: radius.value,
          onChanged: (v) => radius.value = v,
        ),
        ElEvent(
          cursor: SystemMouseCursors.click,
          onTap: () {
            isActive.value = !isActive.value;
          },
          builder: (context) {
            return ElRing(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              show: isActive.value || context.isHover,
              width: isActive.value || context.isHover ? 6 : 0,
              offset: 4,
              radius: borderRadius,
              color: Colors.red,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: isActive.value ? Colors.green : null,
                  border: Border.all(
                    width: 4,
                    color: isActive.value ? Colors.green : Colors.grey,
                  ),
                  borderRadius: borderRadius,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final radius = useState(0.0);
    final isActive = useState(false);

    // ElRing 会自动计算圆角，所以你传递给 ElRing 的圆角值只需要和容器一致就行
    final borderRadius = BorderRadius.circular(radius.value);
    return Column(
      children: [
        Slider(
          min: 0,
          max: 50,
          label: radius.value.round().toString(),
          value: radius.value,
          onChanged: (v) => radius.value = v,
        ),
        ElEvent(
          cursor: SystemMouseCursors.click,
          onTap: () {
            isActive.value = !isActive.value;
          },
          builder: (context) {
            return ElRing(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              show: isActive.value || context.isHover,
              width: isActive.value || context.isHover ? 6 : 0,
              offset: 4,
              radius: borderRadius,
              color: Colors.red,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: isActive.value ? Colors.green : null,
                  border: Border.all(
                    width: 4,
                    color: isActive.value ? Colors.green : Colors.grey,
                  ),
                  borderRadius: borderRadius,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}''';
