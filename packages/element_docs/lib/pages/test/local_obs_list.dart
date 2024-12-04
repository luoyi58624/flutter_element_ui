import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class LocalObsListTest extends HookWidget {
  const LocalObsListTest({super.key});

  @override
  Widget build(BuildContext context) {
    final list = useLocalObs<List<String>>([], cacheKey: 'list_test');
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地持久化 Obs 测试'),
        actions: [
          IconButton(
            onPressed: () {
              list.value = [
                ...list.value,
                ...List.generate(
                  10000,
                  (index) => 'Item - ${list.value.length + index + 1}',
                ),
              ];
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              list.value = [];
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: ObsBuilder(builder: (context) {
        return SuperListView.builder(
          itemCount: list.value.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () {},
            title: Text(list.value[index]),
          ),
        );
      }),
    );
  }
}
