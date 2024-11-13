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
        const SectionCard(
          title: 'Tip',
          content: ['绿色方块使用 ElTap 小部件，当点击红色方块时，绿色方块也会触发事件'],
        ),
        textGap,
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
    final flag = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElSwitch(flag),
            const Gap(8),
            ElText(flag.value ? '阻止事件冒泡' : '允许事件冒泡'),
          ],
        ),
        const Gap(8),
        GestureDetector(
          onTap: () {
            el.message.show('点击 blue 方块', type: El.primary);
          },
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
            alignment: Alignment.center,
            child: ElEvent(
              onTap: () {
                el.message.show('点击 green 方块', type: El.success);
              },
              builder: (context) => Container(
                width: 200,
                height: 200,
                color: Colors.green,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    el.message.show('点击 red 方块', type: El.error);
                    if (flag.value) {
                      // 阻止冒泡事件
                      context.stopPropagation();
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
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
    final flag = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElSwitch(flag),
            const Gap(8),
            ElText(flag.value ? '阻止事件冒泡' : '允许事件冒泡'),
          ],
        ),
        const Gap(8),
        GestureDetector(
          onTap: () {
            el.message.show('点击 blue 方块', type: El.primary);
          },
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
            alignment: Alignment.center,
            child: ElTap(
              onTap: () {
                el.message.show('点击 green 方块', type: El.success);
              },
              builder: (context) => Container(
                width: 200,
                height: 200,
                color: Colors.green,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    el.message.show('点击 red 方块', type: El.error);
                    if (flag.value) {
                      // 阻止冒泡事件
                      context.stopPropagation();
                      // 你需要在合适的时机手动恢复它
                      setTimeout(() {
                        context.resetPropagation();
                      }, 1);
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}''';
