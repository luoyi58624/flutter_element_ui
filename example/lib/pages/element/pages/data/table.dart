import 'package:example/global.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    var data = List.generate(
      100,
      (index) => {
        'id': index + 1,
        'username': faker.person.name(),
        'email': faker.internet.email(),
      },
    ).toList();
    return Container(
      padding: const EdgeInsets.all(8),
      child: ElTable(
        data: data,
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
                ElButton(
                  onPressed: null,
                  child: '编辑',
                  link: true,
                  type: 'primary',
                ),
                Gap(4),
                ElButton(
                  onPressed: null,
                  child: '删除',
                  link: true,
                  type: 'error',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
