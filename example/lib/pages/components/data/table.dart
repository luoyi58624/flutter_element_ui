import 'package:example/global.dart';

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
            width: 140,
            fixedRight: true,
            render: (dataItem) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElTextButton('编辑', type: ElThemeType.primary, onPressed: () {}),
                ElTextButton('删除', type: ElThemeType.error, onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
