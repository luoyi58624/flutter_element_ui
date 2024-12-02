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
    return Stack(
      children: [
        Container(
          height: 300,
          color: context.elTheme.layoutTheme.borderLightColor,
        ),
        Positioned(
          left: 100,
          top: 0,
          bottom: 0,
          child: ElSplit(
            size: 1,
            color: context.elTheme.layoutTheme.borderColor!,
            activeColor: context.elTheme.primary,
          ),
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
    final radius = BorderRadius.circular(8);
    return ElRing(
      show: true,
      radius: radius,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: radius,
        ),
      ),
    );
  }
}''';
