import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';

class Example2 extends HookWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('使用 IOS 滚动条'),
        CodeExampleWidget(
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
    return CupertinoScrollbar(
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
              borderRadius: context.elTheme.cardStyle.radius,
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
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    // 将 El 改为 Cupertino 即可
    return CupertinoScrollbar(
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
              borderRadius: context.elTheme.cardStyle.radius,
            ),
            child: Center(
              child: ElText(
                '\${index + 1}',
                style: TextStyle(color: context.elTheme.primary),
              ),
            ),
          ),
        ).noScrollBehavior, 
      ),
    );
  }
}''';