import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class LocalObsTest extends StatefulWidget {
  const LocalObsTest({super.key});

  @override
  State<LocalObsTest> createState() => _LocalObsTestState();
}

class _LocalObsTestState extends State<LocalObsTest> {
  final username = LocalObs('luoyi', cacheKey: 'username');
  final count = LocalObs(0, cacheKey: 'count');
  final enabled = LocalObs(false, cacheKey: 'enabled');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地持久化 Obs 测试'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ElInput(username),
              const Gap(8),
              ElSwitch(enabled),
              const Gap(8),
              ObsBuilder(builder: (context) {
                return ElButton(
                  onPressed: () {
                    count.value++;
                  },
                  type: El.primary,
                  child: 'count: ${count.value}',
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
