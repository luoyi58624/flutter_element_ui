import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_context_menu/super_context_menu.dart';

import '../../../basic/button/examples/example9.dart';

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
    final count = useState(0);
    return Row(
      spacing: 8,
      children: [
        ElButton(
          onPressed: () {
            ElDialog.showConfirm(context, '标题', 'hello');
          },
          child: '显示弹窗',
        ),
        ElButton(
          onPressed: () {
            el.dialog.show();
          },
          child: '显示全局弹窗',
        ),
        ElButton(
          onPressed: () {
            el.dialog.show(
              modalColor: Colors.transparent,
              // allowInteractive: true,
            );
          },
          child: '显示全局弹窗',
        ),
        ElButton(
          onPressed: () {
            el.dialog.show(
              modalColor: Colors.transparent,
              closeOnClickOutside: true,
              // allowInteractive: true,
            );
          },
          child: '显示全局弹窗',
        ),
        ElButton(
          onPressed: () {
            el.dialog.show(context: context);
          },
          child: '显示局部弹窗',
        ),
        Listener(
          onPointerUp: (e) {
            count.value++;
          },
          onPointerCancel: (e){
            w('取消');
          },
          child: ElButton(child: 'count: ${count.value}'),
        ),
      ],
    );
  }
}

String get code => '''
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class _InputExample extends HookWidget {
  const _InputExample();

  @override
  Widget build(BuildContext context) {
    final input = useState('');
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: ElInput(
            input,
            margin: EdgeInsets.zero,
            placeholder: '请输入内容',
          ),
        ),
        const Gap(8),
        ElText(' - \${input.value}'),
      ],
    );
  }
}''';
