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

  /// 将 Map 转换成实际类型，它通常用于解决反序列化时的 Map 类型转换错误
  dynamic autoCast() {
    return _autoCastMap(this);
  }
}

Map _autoCastMap<K, V>(Map<K, V> map) {
  Map<String, bool> keyTypeMap = {
    'dynamic': false,
    'String': false,
    'int': false,
    'double': false,
    'num': false,
    'bool': false,
  };

  Map<String, bool> valueTypeMap = {
    'dynamic': false,
    'String': false,
    'int': false,
    'double': false,
    'num': false,
    'bool': false,
    'null': false,
    'Object': false,
  };

  map.forEach((k, v) {
    dynamic key = DartUtil.dynamicToBaseType(k, true);
    assert(key != null, 'Map key不是基础数据类型，autoCast失败');
    if (key is int) {
      keyTypeMap['int'] = true;
    } else if (key is double) {
      keyTypeMap['double'] = true;
    } else if (key is bool) {
      keyTypeMap['bool'] = true;
    } else {
      keyTypeMap['String'] = true;
    }

    dynamic value = DartUtil.dynamicToBaseType(v);
    if (value == null) {
      valueTypeMap['null'] = true;
    } else if (value is int) {
      valueTypeMap['int'] = true;
    } else if (value is double) {
      valueTypeMap['double'] = true;
    } else if (value is bool) {
      valueTypeMap['bool'] = true;
    } else if (value is String) {
      valueTypeMap['String'] = true;
    } else if (value is Map) {
    } else {
      valueTypeMap['Object'] = true;
    }
  });

  keyTypeMap = keyTypeMap.filter((k, v) => v == true);
  valueTypeMap = valueTypeMap.filter((k, v) => v == true);

  late String targetKeyType;
  late String targetValueType;

  if (keyTypeMap.length == 1) {
    targetKeyType = keyTypeMap.keys.first;
  } else if (keyTypeMap.length == 3 && keyTypeMap['num'] == true) {
    targetKeyType = 'num';
  } else {
    targetKeyType = 'dynamic';
  }

  if (valueTypeMap.length == 1) {
    targetValueType = valueTypeMap.keys.first;
  } else if (valueTypeMap.length == 3 && valueTypeMap['num'] == true) {
    targetValueType = 'num';
  } else {
    targetValueType = valueTypeMap['null'] == true ? 'dynamic' : 'Object';
  }

  if (targetKeyType == 'dynamic') {
    if (targetValueType == 'Object') {
      return Map<Object, Object>.from(map);
    }
    if (targetValueType == 'String') {
      return Map<Object, String>.from(map);
    }
    if (targetValueType == 'int') {
      return Map<Object, int>.from(map);
    }
    if (targetValueType == 'double') {
      return Map<Object, double>.from(map);
    }
    if (targetValueType == 'num') {
      return Map<Object, num>.from(map);
    }
    if (targetValueType == 'bool') {
      return Map<Object, bool>.from(map);
    }
    return map.cast<Object, dynamic>();
  }
  if (targetKeyType == 'String') {
    if (targetValueType == 'Object') {
      return Map<String, Object>.from(map);
    }
    if (targetValueType == 'String') {
      return Map<String, String>.from(map);
    }
    if (targetValueType == 'int') {
      return Map<String, int>.from(map);
    }
    if (targetValueType == 'double') {
      return Map<String, double>.from(map);
    }
    if (targetValueType == 'num') {
      return Map<String, num>.from(map);
    }
    if (targetValueType == 'bool') {
      return Map<String, bool>.from(map);
    }
    return Map<String, dynamic>.from(map);
  }
  if (targetKeyType == 'int') {
    if (targetValueType == 'Object') {
      return Map<int, Object>.from(map);
    }
    if (targetValueType == 'String') {
      return Map<int, String>.from(map);
    }
    if (targetValueType == 'int') {
      return Map<int, int>.from(map);
    }
    if (targetValueType == 'double') {
      return Map<int, double>.from(map);
    }
    if (targetValueType == 'num') {
      return Map<int, num>.from(map);
    }
    if (targetValueType == 'bool') {
      return Map<int, bool>.from(map);
    }
    return Map<int, dynamic>.from(map);
  }

  if (targetKeyType == 'double') {
    if (targetValueType == 'Object') {
      return Map<double, Object>.from(map);
    }
    if (targetValueType == 'String') {
      return Map<double, String>.from(map);
    }
    if (targetValueType == 'int') {
      return Map<double, int>.from(map);
    }
    if (targetValueType == 'double') {
      return Map<double, double>.from(map);
    }
    if (targetValueType == 'num') {
      return Map<double, num>.from(map);
    }
    if (targetValueType == 'bool') {
      return Map<double, bool>.from(map);
    }
    return Map<double, dynamic>.from(map);
  }
  if (targetKeyType == 'bool') {
    if (targetValueType == 'Object') {
      return Map<bool, Object>.from(map);
    }
    if (targetValueType == 'String') {
      return Map<bool, String>.from(map);
    }
    if (targetValueType == 'int') {
      return Map<bool, int>.from(map);
    }
    if (targetValueType == 'double') {
      return Map<bool, double>.from(map);
    }
    if (targetValueType == 'num') {
      return Map<bool, num>.from(map);
    }
    if (targetValueType == 'bool') {
      return Map<bool, bool>.from(map);
    }
    return Map<bool, dynamic>.from(map);
  }

  if (targetValueType == 'Object') {
    return Map<num, Object>.from(map);
  }
  if (targetValueType == 'String') {
    return Map<num, String>.from(map);
  }
  if (targetValueType == 'int') {
    return Map<num, int>.from(map);
  }
  if (targetValueType == 'double') {
    return Map<num, double>.from(map);
  }
  if (targetValueType == 'num') {
    return Map<num, num>.from(map);
  }
  if (targetValueType == 'bool') {
    return Map<num, bool>.from(map);
  }
  return Map<num, dynamic>.from(map);
}
