import 'package:element_docs/global.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class Example1 extends StatelessWidget {
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
    final data = useState(List.generate(
      10000,
      (index) => {
        'id': index + 1,
        'username': faker.person.name(),
        'email': faker.internet.email(),
      },
    ).toList());
    return Container(
      padding: const EdgeInsets.all(8),
      height: 500,
      child: ElTable(
        data: data.value,
        highlightCurrentRow: false,
        dragScroll: true,
        columns: [
          ElTableColumn(prop: 'id', label: 'ID', width: 80, fixedLeft: true),
          ElTableColumn(prop: 'username', label: '用户名', width: 220),
          ElTableColumn(prop: 'email', label: '邮箱', minWidth: 280),
          ElTableColumn(
            label: '操作',
            width: 100,
            fixedRight: true,
            render: (dataItem) => const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElButton(child: '编辑', link: true, type: El.primary),
                Gap(8),
                ElButton(child: '删除', link: true, type: El.error),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String get code => '''
import 'package:element_docs/global.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final data = useState(List.generate(
      10000,
      (index) => {
        'id': index + 1,
        'username': faker.person.name(),
        'email': faker.internet.email(),
      },
    ).toList());
    return Container(
      padding: const EdgeInsets.all(8),
      height: 500,
      child: ElTable(
        data: data.value,
        highlightCurrentRow: false,
        dragScroll: true,
        columns: [
          ElTableColumn(prop: 'id', label: 'ID', width: 80, fixedLeft: true),
          ElTableColumn(prop: 'username', label: '用户名', width: 220),
          ElTableColumn(prop: 'email', label: '邮箱', minWidth: 280),
          ElTableColumn(
            label: '操作',
            width: 100,
            fixedRight: true,
            render: (dataItem) => const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElButton(child: '编辑', link: true, type: El.primary),
                Gap(8),
                ElButton(child: '删除', link: true, type: El.error),
              ],
            ),
          ),
        ],
      ),
    );
  }
}''';
