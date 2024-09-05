import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class TextTestPage extends HookWidget {
  const TextTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Text 文本性能测试'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: _Text()),
              Expanded(child: _ElText()),
            ],
          ),
        ));
  }
}

class _Text extends HookWidget {
  const _Text();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Column(
      children: [
        const H4('Text 动画测试'),
        ElSwitch(flag),
        Expanded(
          child: SingleChildScrollView(
            child: AnimatedDefaultTextStyle(
              duration: context.elThemeDuration ?? 200.ms,
              style: TextStyle(
                fontSize: flag.value ? 28 : 16,
                color: flag.value ? Colors.green : context.elTheme.textColor,
              ),
              child: Wrap(
                children: const Text('a') * 2000,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ElText extends HookWidget {
  const _ElText();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    final flag2 = useState(false);
    return Column(
      children: [
        const H4('ElText 动画测试'),
        ElSwitch(flag),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElSwitch(flag2),
            ElText(flag2.value ? 'ElText 动画' : 'ElAnimatedDefaultTextStyle 动画'),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: flag2.value
                ? Wrap(
                    children: ElAnimateText(
                          'a',
                          duration: 200.ms,
                          style: TextStyle(
                            fontSize: flag.value ? 28 : 16,
                            color: flag.value
                                ? Colors.yellow
                                : context.elTheme.textColor,
                          ),
                        ) *
                        2000)
                : ElAnimatedDefaultTextStyle(
                    duration: context.elThemeDuration ?? 200.ms,
                    style: TextStyle(
                      fontSize: flag.value ? 28 : 16,
                      color:
                          flag.value ? Colors.green : context.elTheme.textColor,
                    ),
                    child: Wrap(
                      children: const ElText('a') * 2000,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
