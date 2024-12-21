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
    final show = useState(false);
    return Column(
      spacing: 8,
      children: [
        ElDrawer(
          show,
          child: ElButton(
            onPressed: () {
              show.value = true;
            },
            child: '显示Drawer',
          ),
        ),
        ElButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: 'child',
        ),
      ],
    );
  }
}

class DrawerRoute extends PopupRoute {
  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => 'xx';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return UnconstrainedBox(
      child: Container(
        width: 100,
        height: 100,
        color: Colors.green,
      ),
    );
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => const Duration(milliseconds: 200);
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
