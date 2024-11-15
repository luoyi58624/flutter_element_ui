import 'package:element_docs/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Example3 extends HookWidget {
  const Example3({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: [
            '左侧为 ElEvent 嵌套 GestureDetector，右侧为 GestureDetector 嵌套 ElEvent。',
          ],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [
            Row(
              children: [
                _Example(),
                Gap(8),
                _Example2(),
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
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('ElEvent');
          },
          builder: (context) => Container(
            width: 150,
            height: 150,
            color: Colors.grey,
            alignment: Alignment.center,
            child: Listener(
              onPointerDown: (e) {
                context.stopPropagation();
              },
              child: GestureDetector(
                onTap: () {
                  el.message.success('GestureDetector');
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Example2 extends HookWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElBubbleBuilder(
          builder: (stopBubble) => GestureDetector(
            onTap: stopBubble
                ? null
                : () {
                    el.message.show('GestureDetector');
                  },
            child: Container(
              width: 150,
              height: 150,
              color: Colors.grey,
              alignment: Alignment.center,
              child: ElStopPropagation(
                child: ElEvent(
                  onTap: () {
                    el.message.success('ElEvent');
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.green,
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

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('ElEvent');
          },
          builder: (context) => Container(
            width: 150,
            height: 150,
            color: Colors.grey,
            alignment: Alignment.center,
            child: Listener(
              onPointerDown: (e) {
                context.stopPropagation();
              },
              child: GestureDetector(
                onTap: () {
                  el.message.success('GestureDetector');
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}''';
