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
    return SingleChildScrollView(
      child: Column(
        children: [
          const H4('Text 动画测试'),
          ElSwitch(flag),
          AnimatedDefaultTextStyle(
            duration: context.elThemeDuration ?? 1000.ms,
            style: TextStyle(
              fontSize: flag.value ? 28 : 16,
              color: flag.value ? Colors.green : context.elTheme.textColor,
            ),
            child: Wrap(
              children: const Text('这是一段文字') * 1000,
            ),
          )
        ],
      ),
    );
  }
}

class _ElText extends HookWidget {
  const _ElText();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return SingleChildScrollView(
      child: Column(
        children: [
          const H4('ElText 动画测试'),
          ElSwitch(flag),
          ElAnimatedDefaultTextStyle(
            duration: context.elThemeDuration ?? 1000.ms,
            style: TextStyle(
              fontSize: flag.value ? 28 : 16,
              color: flag.value ? Colors.green : context.elTheme.textColor,
            ),
            child: Wrap(
              children: const ElText('这是一段文字') * 1000,
            ),
          ),
        ],
      ),
    );
  }
}
