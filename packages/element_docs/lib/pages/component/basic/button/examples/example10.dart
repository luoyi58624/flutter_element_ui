import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';

class Example10 extends StatelessWidget {
  const Example10({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: ['拆分按钮是具有主要操作和次要操作的按钮，主要用于打开菜单'],
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
    final count = useState(0);
    return ElEventTheme(
      data: ElEventThemeData(
        onTapDown: (e) {
          el.message.primary('点击按钮');
        },
        onCancel: () {
          el.message.error('取消点击');
        },
      ),
      child: ElButton(
        onPressed: () {
          count.value++;
        },
        type: 'primary',
        child: ElText('count: ${count.value}'),
      ),
    );
  }
}

String get code => '''
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [
    ElButton(
      height: 20,
      type: 'primary',
      child: ElText('小型按钮', style: TextStyle(fontSize: 12)),
    ),
    ElButton(
      width: 160,
      height: 48,
      type: 'primary',
      child: ElText('按钮', style: TextStyle(fontSize: 20)),
    ),
    ElButton(
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 28),
      borderRadius: BorderRadius.circular(16),
      type: 'primary',
      child: ElText('按钮', style: TextStyle(fontSize: 24)),
    ),
  ],
),''';
