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
          content: [
            '第一个盒子是嵌套事件的默认行为，默认情况下子容器的事件会冒泡到外层，所以点击 green 方块会同时触发 blue 方块。',
            '要解决事件冒泡只需在中间插入一个 ElStopPropagation 小部件，以下示例便是此解决方案。',
            '第三个盒子在第二个盒子基础上再嵌套了一个 red 盒子，blue 方块和 red 方块之间没有插入 ElStopPropagation，所以它们会同时触发事件。',
            '第四个盒子则在 red 和 blue 之间也插入 ElStopPropagation，这样便可以解决它们之间的事件冒泡。'
          ],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('点击 blue 方块', type: El.primary);
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue,
            alignment: Alignment.center,
            child: ElEvent(
              onTap: () {
                el.message.show('点击 green 方块', type: El.success);
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.green,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('点击 blue 方块', type: El.primary);
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue,
            alignment: Alignment.center,
            // 添加 ElStopPropagation 小部件即可阻止事件冒泡
            child: ElStopPropagation(
              child: ElEvent(
                onTap: () {
                  el.message.show('点击 green 方块', type: El.success);
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

class _Example3 extends HookWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('点击 red 方块', type: El.error);
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.red,
            alignment: Alignment.center,
            child: ElEvent(
              onTap: () {
                el.message.show('点击 blue 方块', type: El.primary);
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                alignment: Alignment.center,
                child: ElStopPropagation(
                  child: ElEvent(
                    onTap: () {
                      el.message.show('点击 green 方块', type: El.success);
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
    );
  }
}

class _Example4 extends HookWidget {
  const _Example4();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('点击 red 方块', type: El.error);
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.red,
            alignment: Alignment.center,
            child: ElStopPropagation(
              child: ElEvent(
                onTap: () {
                  el.message.show('点击 blue 方块', type: El.primary);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: ElStopPropagation(
                    child: ElEvent(
                      onTap: () {
                        el.message.show('点击 green 方块', type: El.success);
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
    );
  }
}

String get code => '''
class _Example2 extends HookWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElEvent(
          onTap: () {
            el.message.show('点击 blue 方块', type: El.primary);
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue,
            alignment: Alignment.center,
            // 添加 ElStopPropagation 小部件即可阻止事件冒泡
            child: ElStopPropagation(
              child: ElEvent(
                onTap: () {
                  el.message.show('点击 green 方块', type: El.success);
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
