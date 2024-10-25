import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class TextAnimateTestPage extends HookWidget {
  const TextAnimateTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textCount = useState(500.0);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Text 文本性能测试'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Slider(
                min: 100,
                max: 5000,
                label: textCount.value.round().toString(),
                value: textCount.value,
                onChanged: (v) => textCount.value = v,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _Text(textCount.value.toInt())),
                    Expanded(child: _ElText(textCount.value.toInt())),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _Text extends HookWidget {
  const _Text(this.count);

  final int count;

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
              duration: context.elDuration(300.ms),
              style: flag.value
                  ? const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    )
                  : ElTextTheme.of(context).style,
              child: Wrap(
                children: const Text('Text') * count,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _ElText extends HookWidget {
  const _ElText(this.count);

  final int count;

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
            ElText(flag2.value ? 'ElAnimatedDefaultTextStyle' : 'ElText 动画'),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: flag2.value
                ? ElTextTheme(
                    data: ElTextThemeData(
                      duration: context.elDuration(300.ms),
                      style: flag.value
                          ? const TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                            )
                          : ElTextTheme.of(context).style,
                    ),
                    child: Wrap(
                      children: const ElText('Text') * count,
                    ),
                  )
                : Wrap(
                    children: ElText(
                          'Text',
                          duration: 300.ms,
                          style: flag.value
                              ? const TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                )
                              : null,
                        ) *
                        count),
          ),
        ),
      ],
    );
  }
}
