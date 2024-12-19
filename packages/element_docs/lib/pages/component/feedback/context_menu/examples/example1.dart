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
    return Row(
      children: [
        Expanded(
          child: Column(
            spacing: 8,
            children: [
              _ElContextMenu(
                child: ElButton(
                  onPressed: () {},
                  child: '右键菜单',
                ),
              ),
              _ElContextMenu(
                child: ElButton(
                  onPressed: () {},
                  type: El.primary,
                  child: '右键菜单',
                ),
              ),
              _ElContextMenu(
                child: CustomButton(
                  onPressed: () {},
                  child: '右键菜单',
                ),
              ),
              _ElContextMenu(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('右键菜单'),
                ),
              ),
              _ElContextMenu(
                child: CupertinoButton.filled(
                  onPressed: () {},
                  child: const Text('右键菜单'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            spacing: 8,
            children: [
              _NativeContextMenu(
                child: ElButton(
                  onPressed: () {},
                  child: '右键菜单',
                ),
              ),
              _NativeContextMenu(
                child: ElButton(
                  onPressed: () {},
                  type: El.primary,
                  child: '右键菜单',
                ),
              ),
              _NativeContextMenu(
                child: CustomButton(
                  onPressed: () {},
                  child: '右键菜单',
                ),
              ),
              _NativeContextMenu(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('右键菜单'),
                ),
              ),
              _NativeContextMenu(
                child: CupertinoButton.filled(
                  onPressed: () {},
                  child: const Text('右键菜单'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ElContextMenu extends StatelessWidget {
  const _ElContextMenu({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElContextMenu(
      menu: ElMenu(),
      child: child,
    );
  }
}

class _NativeContextMenu extends StatelessWidget {
  const _NativeContextMenu({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ContextMenuWidget(
      child: child,
      menuProvider: (_) {
        return Menu(
          children: [
            MenuAction(
              title: 'Menu Item 1',
              callback: () {
                el.message.show('menu item 1');
              },
            ),
            MenuAction(
              title: 'Menu Item 2',
              callback: () {
                el.message.primary('menu item 2');
              },
            ),
            MenuSeparator(),
            Menu(title: 'Submenu', children: [
              MenuAction(
                title: 'Submenu Item 1',
                callback: () {
                  el.message.success('sub_menu item 1');
                },
              ),
              MenuAction(title: 'Submenu Item 2', callback: () {}),
              Menu(title: 'Nested Submenu', children: [
                MenuAction(title: 'Submenu Item 1', callback: () {}),
                MenuAction(title: 'Submenu Item 2', callback: () {}),
              ]),
            ]),
          ],
        );
      },
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
