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
  final localColor = LocalObs(
    Colors.red,
    cacheKey: 'local_color',
    serialize: const ElMaterialColorSerialize(),
  );

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
              const Gap(8),
              ObsBuilder(builder: (context) {
                return Container(
                  width: 100,
                  height: 100,
                  color: localColor.value,
                );
              }),
              const Gap(8),
              buildPresetColors(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPresetColors(BuildContext context) {
    return Wrap(
      children: [
        ElThemeData.theme.primary,
        ElThemeData.theme.warning,
        ...Colors.primaries
      ].map((color) {
        return ObsBuilder(builder: (context) {
          final isActive = localColor.value == color.toMaterialColor();
          return Material(
            child: Ink(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: color),
              child: InkWell(
                onTap: () {
                  localColor.value = color.toMaterialColor();
                },
                child: Container(
                  child: isActive
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          );
        });
      }).toList(),
    );
  }
}
