import 'dart:convert';

import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalStorageTestPage extends StatelessWidget {
  const LocalStorageTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LocalStorage Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const _BigDataPage()));
              },
              child: const Text('big data test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const _DateTimeListStoragePage()));
              },
              child: const Text('DateTime Local List'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                localStorage.setItem('string', 'local_data');
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(localStorage.getItem('string') ?? 'null'),
                ));
              },
              child: const Text('set string'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                localStorage.setItem('int', 100);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${localStorage.getItem('int') ?? 'null'}"),
                ));
              },
              child: const Text('set int'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                localStorage.setItem('double', 1000.23);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${localStorage.getItem('double') ?? 'null'}"),
                ));
              },
              child: const Text('set double'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                localStorage.setItem('bool', true);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${localStorage.getItem('bool') ?? 'null'}"),
                ));
              },
              child: const Text('set bool'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                localStorage.setItem(
                  'color',
                  context.elTheme.primary,
                  const ElColorSerialize(),
                );
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("设置成功，请长按查看颜色"),
                ));
              },
              onLongPress: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "${localStorage.getItem('color', const ElColorSerialize()) ?? 'null'}"),
                ));
              },
              child: const Text('set color'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                localStorage.clear();
              },
              child: const Text('clear'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BigDataPage extends StatefulWidget {
  const _BigDataPage();

  @override
  State<_BigDataPage> createState() => _BigDataPageState();
}

class _BigDataPageState extends State<_BigDataPage> {
  final ScrollController controller = ScrollController();
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    String? listStr = localStorage.getItem('list');
    if (listStr != null) {
      dataList
          .addAll((jsonDecode(listStr) as List).cast<Map<String, dynamic>>());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('大量数据测试'),
        actions: [
          IconButton(
            onPressed: () {
              dataList.clear();
              localStorage.setItem('list', jsonEncode(dataList));
              setState(() {});
            },
            icon: const Icon(Icons.clear),
          ),
          IconButton(
            tooltip: '插入 10 万条数据',
            onPressed: () {
              int start = dataList.length;
              final newList = List.generate(
                100000,
                (index) => {'list - ${start + index}': 'hihi'},
              );
              dataList.addAll(newList);
              localStorage.setItem('list', jsonEncode(dataList));
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: CupertinoScrollbar(
        controller: controller,
        child: SuperListView.builder(
          controller: controller,
          itemCount: dataList.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () {},
            title: Text(dataList[index].toString()),
          ),
        ),
      ).noScrollBehavior,
    );
  }
}

class ElListDateTimeSerialize implements ElSerialize<List<DateTime>> {
  const ElListDateTimeSerialize();

  @override
  String? serialize(List<DateTime>? obj) {
    if (obj == null) return null;
    final result = jsonEncode(
        obj.map((e) => e.millisecondsSinceEpoch.toString()).toList());
    return result;
  }

  @override
  List<DateTime>? deserialize(String? str) {
    if (str == null) return null;
    final List<String> list = (jsonDecode(str) as List).cast<String>();
    return list
        .map((e) => DateTime.fromMillisecondsSinceEpoch(int.parse(e)))
        .toList();
  }
}

class _DateTimeListStoragePage extends HookWidget {
  const _DateTimeListStoragePage();

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final dataList = useState<List<DateTime>>([]);

    useInit(() {
      dataList.value = localStorage.getItem(
            'date_time_list',
            const ElListDateTimeSerialize(),
          ) ??
          [];
    });

    useWatch(dataList, (newValue, oldValue) {
      localStorage.setItem(
        'date_time_list',
        dataList.value,
        const ElListDateTimeSerialize(),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('大量数据测试'),
        actions: [
          IconButton(
            onPressed: () {
              dataList.value = [];
            },
            icon: const Icon(Icons.clear),
          ),
          IconButton(
            onPressed: () {
              final newList = List.generate(
                100000,
                (index) => DateTime.now(),
              );
              dataList.value = [...dataList.value, ...newList];
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: CupertinoScrollbar(
        controller: controller,
        child: SuperListView.builder(
          controller: controller,
          itemCount: dataList.value.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () {},
            title: Text(dataList.value[index].toString()),
          ),
        ),
      ).noScrollBehavior,
    );
  }
}
