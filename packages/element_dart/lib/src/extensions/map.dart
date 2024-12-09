import 'dart:collection';

import 'package:collection/collection.dart';

import '../utils/util.dart';

extension DartMapExtension<K, V> on Map<K, V> {
  /// 判断两个 Map 是否相等
  bool eq(Map other) {
    return const MapEquality().equals(this, other);
  }

  /// 根据条件返回一个新的Map
  Map<K, V> filter(bool Function(K key, V value) test) {
    Map<K, V> newMap = {};
    for (K k in keys) {
      if (test(k, this[k] as V)) {
        newMap[k] = this[k] as V;
      }
    }
    return newMap;
  }

  /// 根据keys集合，返回一个新的Map
  Map<K, V> filterFromKeys(List<K> keys) {
    Map<K, V> newMap = {};
    for (K key in keys) {
      newMap[key] = this[key] as V;
    }
    return newMap;
  }
}
