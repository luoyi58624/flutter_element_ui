import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example2 extends HookWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(code: code, children: const [
          _Example(),
        ]),
      ],
    );
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final tabCount = useState(5);
    final tabs = List.generate(
      tabCount.value,
      (index) => '标签${index + 1}',
    ).toList();
    return Column(
      children: [
        Row(
          children: [
            ElButton(
              onPressed: () {
                tabCount.value++;
              },
              child: '新增标签',
            ),
            const Gap(8),
            ElButton(
              onPressed: () {
                tabCount.value--;
              },
              child: '删除标签',
            ),
          ],
        ),
        const Gap(8),
        DefaultTabController(
          length: tabs.length,
          child: SizedBox(
            height: 500,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("App Name"),
                bottom: TabBar(
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                ),
              ),
              body: TabBarView(
                children: tabs.map((e) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(e),
                  );
                }).toList(),
              ),
            ),
          ),
        ).noScrollBehavior,
      ],
    );
  }
}

String get code => '''
''';
