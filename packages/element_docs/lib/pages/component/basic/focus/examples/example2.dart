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
            '如果按钮处于焦点组中，那么按下它便可得到焦点',
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [null, ...El.themeTypes]
                .map((type) => ElButton(child: 'Hello', type: type))
                .toList(),
          ),
          const Gap(20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [null, ...El.themeTypes]
                .map((type) => ElOutlineButton(child: 'Hello', type: type))
                .toList(),
          ),
          const Gap(20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [null, ...El.themeTypes]
                .map((type) => ElTextButton(child: 'Hello', type: type))
                .toList(),
          ),
          const Gap(20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [null, ...El.themeTypes]
                .map((type) => ElLinkButton(child: 'Link', type: type))
                .toList(),
          ),
        ],
      ),
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return ElFocusScope(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [null, ...El.themeTypes]
                .map((type) => ElButton(child: 'Hello', type: type))
                .toList(),
          ),
          const Gap(20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [null, ...El.themeTypes]
                .map((type) => ElOutlineButton(child: 'Hello', type: type))
                .toList(),
          ),
          const Gap(20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [null, ...El.themeTypes]
                .map((type) => ElTextButton(child: 'Hello', type: type))
                .toList(),
          ),
          const Gap(20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [null, ...El.themeTypes]
                .map((type) => ElLinkButton(child: 'Link', type: type))
                .toList(),
          ),
        ],
      ),
    );
  }
}''';
