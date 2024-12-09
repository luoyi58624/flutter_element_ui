import 'dart:convert';

import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SessionStorageTestPage extends StatelessWidget {
  const SessionStorageTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SessionStorage 测试'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BigDataPage()));
              },
              child: const Text('big data test'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                sessionStorage.setItem('string', 'local_data');
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(sessionStorage.getItem('string') ?? 'null'),
                ));
              },
              child: const Text('set string'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                sessionStorage.setItem('int', 100);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${sessionStorage.getItem('int') ?? 'null'}"),
                ));
              },
              child: const Text('set int'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                sessionStorage.setItem('double', 1000.23);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text("${sessionStorage.getItem('double') ?? 'null'}"),
                ));
              },
              child: const Text('set double'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                sessionStorage.setItem('bool', true);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${sessionStorage.getItem('bool') ?? 'null'}"),
                ));
              },
              child: const Text('set bool'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                sessionStorage.clear();
              },
              child: const Text('clear'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigDataPage extends StatefulWidget {
  const BigDataPage({super.key});

  @override
  State<BigDataPage> createState() => _BigDataPageState();
}

class _BigDataPageState extends State<BigDataPage> {
  final ScrollController controller = ScrollController();
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    String? listStr = sessionStorage.getItem('list');
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
              sessionStorage.setItem('list', jsonEncode(dataList));
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
              sessionStorage.setItem('list', jsonEncode(dataList));
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
