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
          content: [
            '如果 ElEvent 祖先存在 ElFocusScope 小部件，那么在指针按下时会预选中焦点（仅限桌面端，移动端依旧需要等待点击事件触发，因为需要避免滑动时误触），'
                '如果 ElFocusScope 已经处于激活状态，那么按下时会立即请求焦点，否则会在点击事件触发时再请求焦点。'
          ],
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

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return ElFocusScope(
      child: Row(
        children: [
          focusWidget,
          const Gap(8),
          focusWidget,
          const Gap(8),
          focusWidget,
        ],
      ),
    );
  }

  Widget get focusWidget {
    return ElEvent(
      builder: (context) {
        return Container(
          width: 50,
          height: 50,
          color: Focus.of(context).hasFocus ? Colors.green : Colors.grey,
        );
      },
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return ElFocusScope(
      child: Row(
        children: [
          focusWidget,
          const Gap(8),
          focusWidget,
          const Gap(8),
          focusWidget,
        ],
      ),
    );
  }

  Widget get focusWidget {
    return ElEvent(
      builder: (context) {
        return Container(
          width: 50,
          height: 50,
          color: Focus.of(context).hasFocus ? Colors.green : Colors.grey,
        );
      },
    );
  }
}''';
