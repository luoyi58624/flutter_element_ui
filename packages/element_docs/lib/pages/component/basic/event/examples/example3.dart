import 'package:element_docs/global.dart';
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
            'ElEvent 可以嵌套任意小部件：Listener、GestureDetector、InkWell，'
                '要阻止事件冒泡只需要在中间插入 ElStopPropagation 小部件即可，',
            '但反过来则稍微麻烦一点，你需要在最外层插入 ElBubbleBuilder 小部件，然后通过 ElBubbleBuilder.of 获取冒泡标识手动控制外层逻辑的执行。'
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
                child: ElStopPropagation(
                  child: GestureDetector(
                    onTap: () {
                      el.message.error('Parent GestureDetector');
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          el.message.success('Child GestureDetector');
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
            // ElBubbleBuilder 可以捕获 ElStopPropagation 发射的阻止冒泡标识，
            // 然后通过 ElBubbleBuilder.of(context) 访问冒泡标识手动阻止逻辑执行，
            // 这种方式会引起 UI 重建（按下、抬起）
            ElBubbleBuilder(
              builder: (context) => GestureDetector(
                onTap: ElBubbleBuilder.of(context)
                    ? null
                    : () {
                        el.message.show('Parent GestureDetector');
                      },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: ElBubbleBuilder.of(context)
                        ? null
                        : () {
                            el.message.error('Child GestureDetector');
                          },
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                      alignment: Alignment.center,
                      // 阻止事件冒泡
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
              builder: (context) => Card(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.zero,
                child: InkWell(
                  onTap: ElBubbleBuilder.of(context)
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
              builder: (context) => Card(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.zero,
                child: InkWell(
                  mouseCursor: MouseCursor.defer,
                  onTap: ElBubbleBuilder.of(context)
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
            // ElBubbleBuilder 可以捕获 ElStopPropagation 发射的阻止冒泡标识，
            // 然后通过 ElBubbleBuilder.of(context) 访问冒泡标识手动阻止逻辑执行，
            // 这种方式会引起 UI 重建（按下、抬起）
            ElBubbleBuilder(
              builder: (context) => GestureDetector(
                onTap: ElBubbleBuilder.of(context)
                    ? null
                    : () {
                        el.message.show('Parent GestureDetector');
                      },
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: ElBubbleBuilder.of(context)
                        ? null
                        : () {
                            el.message.error('Child GestureDetector');
                          },
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                      alignment: Alignment.center,
                      // 阻止事件冒泡
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
}''';
