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
        FlatCodeExample(
          code: code,
          maxHeight: 600,
          child: const _Example(),
        ),
      ],
    );
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final activeMenu = Obs('3-1');
    const List<ElMenuModel> menuList = [
      ElMenuModel(
        title: '菜单一',
        key: '1',
      ),
      ElMenuModel(
        title: '菜单二',
        key: '2',
      ),
      ElMenuModel(title: '菜单三', key: '3', children: [
        ElMenuModel(
          title: '菜单三 - 1',
          key: '3-1',
        ),
        ElMenuModel(
          title: '菜单三 - 2',
          key: '3-2',
        ),
        ElMenuModel(title: '菜单三 - 3', key: '3-3', children: [
          ElMenuModel(
            title: '菜单三 - 3 - 1',
            key: '3-3-1',
          ),
          ElMenuModel(
            title: '菜单三 - 3 - 2',
            key: '3-3-2',
          ),
          ElMenuModel(
            title: '菜单三 - 3 - 3',
            key: '3-3-3',
          ),
        ]),
      ]),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElButton(
              onPressed: () {
                activeMenu.value = '3-3-3';
              },
              type: 'primary',
              child: '选中3-3-3',
            ),
            const Gap(8),
            ObsBuilder(builder: (context) {
              return ElNavMenu(
                menuList,
                activeKey: activeMenu.value,
                onChange: (v) {
                  activeMenu.value = v.key;
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final activeMenu = Obs('3-1');
    const List<ElMenuModel> menuList = [
      ElMenuModel(
        title: '菜单一',
        key: '1',
      ),
      ElMenuModel(
        title: '菜单二',
        key: '2',
      ),
      ElMenuModel(title: '菜单三', key: '3', children: [
        ElMenuModel(
          title: '菜单三 - 1',
          key: '3-1',
        ),
        ElMenuModel(
          title: '菜单三 - 2',
          key: '3-2',
        ),
        ElMenuModel(title: '菜单三 - 3', key: '3-3', children: [
          ElMenuModel(
            title: '菜单三 - 3 - 1',
            key: '3-3-1',
          ),
          ElMenuModel(
            title: '菜单三 - 3 - 2',
            key: '3-3-2',
          ),
          ElMenuModel(
            title: '菜单三 - 3 - 3',
            key: '3-3-3',
          ),
        ]),
      ]),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElButton(
              onPressed: () {
                activeMenu.value = '3-3-3';
              },
              child: '选中3-3-3',
            ),
            const Gap(8),
            ObsBuilder(builder: (context) {
              return ElNavMenu(
                menuList,
                activeKey: activeMenu.value,
                onChange: (v) {
                  activeMenu.value = v.key;
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}''';
