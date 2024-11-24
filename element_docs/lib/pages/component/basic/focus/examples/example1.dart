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
    return Row(
      children: [
        buildWidget(),
        const Gap(8),
        buildWidget(),
        const Gap(8),
        buildWidget(),
      ],
    );
  }

  Widget buildWidget() => Focus(
        child: Builder(builder: (context) {
          final focus = Focus.of(context);
          return ElEvent(
            onTapDown: (e) {
              focus.requestFocus();
            },
            child: Builder(builder: (context) {
              return Container(
                width: 100,
                height: 100,
                color: focus.hasFocus ? Colors.green : Colors.grey,
              );
            }),
          );
        }),
      );
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildWidget(),
        const Gap(8),
        buildWidget(),
        const Gap(8),
        buildWidget(),
      ],
    );
  }

  Widget buildWidget() => ElFocus(
        child: Builder(builder: (context) {
          final focus = Focus.of(context);
          return ElEvent(
            onTapDown: (e) {
              focus.requestFocus();
            },
            child: Builder(builder: (context) {
              return Container(
                width: 100,
                height: 100,
                color: focus.hasFocus ? Colors.green : Colors.grey,
              );
            }),
          );
        }),
      );
}''';
