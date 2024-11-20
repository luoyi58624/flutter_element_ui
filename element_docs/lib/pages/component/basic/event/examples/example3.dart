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
            ElText([
              '上面的示例仅限于 ElEvent 嵌套 ElEvent，这个示例是处理 ',
              LinkWidgets.gestureDetector,
              ' 小部件的事件冲突，它稍微麻烦一点。'
            ]),
          ],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [
            ElDefaultTextStyle(
              style: TextStyle(
                fontSize: 12,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _Example(),
                    Gap(10),
                    _Example2(),
                    Gap(10),
                    _Example3(),
                    Gap(10),
                    _Example4(),
                  ],
                ),
              ),
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
    return Column(
      children: [
        const ElText('ElEvent -> GestureDetector'),
        const Gap(8),
        Wrap(
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
                // 你必须在 Listener 中阻止事件冲突，因为 GestureDetector 内部执行的逻辑比较多，
                // 手指轻触屏幕时，onTapDown 的触发时机可能比 ElEvent 的 onTap 还要慢
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
        ),
      ],
    );
  }
}

class _Example2 extends HookWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ElText('GestureDetector -> ElEvent'),
        const Gap(8),
        Wrap(
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
        ),
      ],
    );
  }
}

class _Example3 extends HookWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ElText('InkWell -> GestureDetector'),
        const Gap(8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElBubbleBuilder(
              builder: (stopBubble) => Card(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.zero,
                child: InkWell(
                  onTap: stopBubble
                      ? null
                      : () {
                          el.message.show('InkWell');
                        },
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Center(
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
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Example4 extends HookWidget {
  const _Example4();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ElText('InkWell -> ElEvent'),
        const Gap(8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElBubbleBuilder(
              builder: (stopBubble) => Card(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.zero,
                child: InkWell(
                  mouseCursor: MouseCursor.defer,
                  onTap: stopBubble
                      ? null
                      : () {
                          el.message.show('InkWell');
                        },
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Center(
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
              ),
            ),
          ],
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
            // 你必须在 Listener 中阻止事件冲突，因为 GestureDetector 内部执行的逻辑比较多，
            // 手指轻触屏幕时，onTapDown 的触发时机可能比 ElEvent 的 onTap 还要慢
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
