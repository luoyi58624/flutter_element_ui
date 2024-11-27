import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../button/index.dart';

class Example4 extends HookWidget {
  const Example4({super.key, required this.title});

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

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return ElFocusScope(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          focusWidget,
          focusWidget,
          focusWidget,
        ],
      ),
    );
  }

  Widget get focusWidget {
    // 第一层焦点容器盒子
    return ElEvent(
      child: Builder(builder: (context) {
        // 记录一个bug: Container 颜色不能动态设置为 null，否则会造成后代 Widget 被销毁
        return Container(
          width: 250,
          height: 100,
          color: Focus.of(context).hasFocus
              ? context.isDark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200
              : context.elTheme.layoutTheme.bgColor,
          // 第二层焦点按钮盒子
          child: const ElFocusScope(
            child: Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(child: 'Hello', type: El.primary),
                  ElButton(child: 'Hello', type: El.success),
                  ElButton(child: 'Hello', type: El.info),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return ElFocusScope(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          focusWidget,
          focusWidget,
          focusWidget,
        ],
      ),
    );
  }

  Widget get focusWidget {
    // 第一层焦点容器盒子
    return ElEvent(
      child: Builder(builder: (context) {
        // 记录一个bug: Container 颜色不能动态设置为 null，否则会造成后代 Widget 被销毁
        return Container(
          width: 250,
          height: 100,
          color: Focus.of(context).hasFocus
              ? context.isDark
              ? Colors.grey.shade800
              : Colors.grey.shade200
              : context.elTheme.layoutTheme.bgColor,
          // 第二层焦点按钮盒子
          child: const ElFocusScope(
            child: Center(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElButton(child: 'Hello', type: El.primary),
                  ElButton(child: 'Hello', type: El.success),
                  ElButton(child: 'Hello', type: El.info),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}''';
