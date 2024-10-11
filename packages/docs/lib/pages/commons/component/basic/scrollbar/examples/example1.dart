import 'package:docs/global.dart';
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
        const SectionText(
            '下面这个示例仅供参考，通常情况下你不需要手动添加滚动条，因为 ElApp 默认使用 ElScrollBehavior 作为全局滚动配置'),
        textGap,
        CodeExample(
          code: code,
          children: const [
            SizedBox(
              height: 300,
              child: _ScrollbarExample(),
            ),
          ],
        ),
      ],
    );
  }
}

class _ScrollbarExample extends StatefulWidget {
  const _ScrollbarExample();

  @override
  State<_ScrollbarExample> createState() => _ScrollbarExampleState();
}

class _ScrollbarExampleState extends State<_ScrollbarExample> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ElScrollbar(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ListView.builder(
          controller: controller,
          itemCount: 20,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: context.elTheme.primary.elLight9(context),
              borderRadius: context.elTheme.cardTheme.radius,
            ),
            child: Center(
              child: ElText(
                '${index + 1}',
                style: TextStyle(color: context.elTheme.primary),
              ),
            ),
          ),
        ).noScrollBehavior,
      ),
    );
  }
}

String get code => '''
class _ScrollbarExample extends StatefulWidget {
  const _ScrollbarExample();

  @override
  State<_ScrollbarExample> createState() => _ScrollbarExampleState();
}

class _ScrollbarExampleState extends State<_ScrollbarExample> {
  // 手动添加滚动条必须创建滚动控制器
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ElScrollbar(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ListView.builder(
          controller: controller,
          itemCount: 20,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: context.elTheme.primary.elLight9(context),
              borderRadius: context.elTheme.cardTheme.radius,
            ),
            child: Center(
              child: ElText(
                '\${index + 1}',
                style: TextStyle(color: context.elTheme.primary),
              ),
            ),
          ),
        ).noScrollBehavior, 
        // noScrollBehavior 是 Element UI 提供的不使用默认滚动配置的扩展函数，
        // 如果你不添加此函数，那么将会绘制两条滚动条，这种行为属于正常现象，
        // 因为 ElScrollBehavior 已经提供了默认滚动条。
      ),
    );
  }
}''';
