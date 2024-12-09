import 'dart:convert';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class MapSerialize implements ElSerialize<Map> {
  const MapSerialize();

  @override
  String? serialize(Map? data) => jsonEncode(data);

  @override
  Map? deserialize(String? str) =>
      str == null ? null : (jsonDecode(str) as Map).autoCast();
}

class LocalObsMapTest extends HookWidget {
  const LocalObsMapTest({super.key});

  @override
  Widget build(BuildContext context) {
    final localMap = useLocalObs(
      {'name': 'hihi', 'count': 1},
      cacheKey: 'local_map',
    );

    final localStringMap = useLocalObs<Map<String, String>>(
      {'name': 'hihi'},
      cacheKey: 'local_string_map',
    );

    final localIntMap = useLocalObs<Map<String, int>>(
      {'count': 1},
      cacheKey: 'local_int_map',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('LocalObs Map 对象测试'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ElInput(
                localMap.value['name'],
                onChanged: (v) {
                  localMap.value = {
                    ...localMap.value,
                    'name': v,
                  };
                },
              ),
              const Gap(8),
              ObsBuilder(builder: (context) {
                return ElText(localMap.value['name']);
              }),
              const Gap(8),
              ObsBuilder(builder: (context) {
                return ElButton(
                  onPressed: () {
                    final currentValue = localMap.value['count'] as int;
                    localMap.value = {
                      ...localMap.value,
                      'count': currentValue + 1,
                    };
                  },
                  type: El.primary,
                  child: 'count: ${localMap.value['count']}',
                );
              }),
              const Gap(20),
              const ElText('================================================'),
              const ElText('=========== 上方动态 Map，下方指定具体类型 ============'),
              const ElText('================================================'),
              const Gap(20),
              ElInput(
                localStringMap.value['name'],
                onChanged: (v) {
                  localStringMap.value = {
                    ...localStringMap.value,
                    'name': v,
                  };
                },
              ),
              const Gap(8),
              ObsBuilder(builder: (context) {
                return ElText(localStringMap.value['name']);
              }),
              const Gap(8),
              ObsBuilder(builder: (context) {
                return ElButton(
                  onPressed: () {
                    final currentValue = localIntMap.value['count'] as int;
                    localIntMap.value = {
                      ...localIntMap.value,
                      'count': currentValue + 1,
                    };
                  },
                  type: El.primary,
                  child: 'count: ${localIntMap.value['count']}',
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
