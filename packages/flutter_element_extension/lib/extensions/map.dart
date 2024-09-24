import 'dart:collection';

import 'package:flutter_element_extension/utils/common.dart';

extension ElMapExtension<K, V> on Map<K, V> {
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

  /// 将 Map 转换成实际类型，例如：
  /// ```dart
  /// // runtimeType: _Map<dynamic, dynamic>
  /// Map map = {'name': 'hihi', 'age': 20};
  ///
  /// // runtimeType: _Map<String, Object>
  /// Map castMap = DartUtil.mapAutoCast(map);
  ///
  /// // runtimeType: _Map<dynamic, dynamic>
  /// Map map2 = {'name': 'hihi', 'age': 20, 'test': null};
  ///
  /// // runtimeType: _Map<String, dynamic>
  /// Map castMap2 = DartUtil.mapAutoCast(map2);
  /// ```
  dynamic autoCast() {
    return _autoCastMap(this);
  }
}

/// 自动转换Map的实际类型
Map _autoCastMap<K, V>(Map<K, V> map) {
  Map<String, bool> keyTypeMap = {
    'dynamic': false,
    'string': false,
    'int': false,
    'double': false,
    'num': false,
    'bool': false,
  };

  Map<String, bool> valueTypeMap = {
    'dynamic': false,
    'string': false,
    'int': false,
    'double': false,
    'num': false,
    'bool': false,
    'null': false,
    'object': false,
  };

  map.forEach((k, v) {
    dynamic key = ElUtil.dynamicToBaseType(k, true);
    assert(key != null, 'Map key不是基础数据类型，autoCast失败');
    if (key is int) {
      keyTypeMap['int'] = true;
    } else if (key is double) {
      keyTypeMap['double'] = true;
    } else if (key is bool) {
      keyTypeMap['bool'] = true;
    } else {
      keyTypeMap['string'] = true;
    }

    dynamic value = ElUtil.dynamicToBaseType(v);
    if (value == null) {
      valueTypeMap['null'] = true;
    } else if (value is int) {
      valueTypeMap['int'] = true;
    } else if (value is double) {
      valueTypeMap['double'] = true;
    } else if (value is bool) {
      valueTypeMap['bool'] = true;
    } else if (value is String) {
      valueTypeMap['string'] = true;
    } else if (value is Map) {
    } else {
      valueTypeMap['object'] = true;
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
    targetValueType = valueTypeMap['null'] == true ? 'dynamic' : 'object';
  }

  if (targetKeyType == 'dynamic') {
    if (targetValueType == 'object') {
      return LinkedHashMap<Object, Object>.from(map);
    }
    if (targetValueType == 'string') {
      return LinkedHashMap<Object, String>.from(map);
    }
    if (targetValueType == 'int') {
      return LinkedHashMap<Object, int>.from(map);
    }
    if (targetValueType == 'double') {
      return LinkedHashMap<Object, double>.from(map);
    }
    if (targetValueType == 'num') {
      return LinkedHashMap<Object, num>.from(map);
    }
    if (targetValueType == 'bool') {
      return LinkedHashMap<Object, bool>.from(map);
    }
    return map.cast<Object, dynamic>();
  } else {
    if (targetKeyType == 'string') {
      if (targetValueType == 'object') {
        return LinkedHashMap<String, Object>.from(map);
      }
      if (targetValueType == 'string') {
        return LinkedHashMap<String, String>.from(map);
      }
      if (targetValueType == 'int') {
        return LinkedHashMap<String, int>.from(map);
      }
      if (targetValueType == 'double') {
        return LinkedHashMap<String, double>.from(map);
      }
      if (targetValueType == 'num') {
        return LinkedHashMap<String, num>.from(map);
      }
      if (targetValueType == 'bool') {
        return LinkedHashMap<String, bool>.from(map);
      }
      return LinkedHashMap<String, dynamic>.from(map);
    }
    if (targetKeyType == 'int') {
      if (targetValueType == 'object') {
        return LinkedHashMap<int, Object>.from(map);
      }
      if (targetValueType == 'string') {
        return LinkedHashMap<int, String>.from(map);
      }
      if (targetValueType == 'int') {
        return LinkedHashMap<int, int>.from(map);
      }
      if (targetValueType == 'double') {
        return LinkedHashMap<int, double>.from(map);
      }
      if (targetValueType == 'num') {
        return LinkedHashMap<int, num>.from(map);
      }
      if (targetValueType == 'bool') {
        return LinkedHashMap<int, bool>.from(map);
      }
      return LinkedHashMap<int, dynamic>.from(map);
    }

    if (targetKeyType == 'double') {
      if (targetValueType == 'object') {
        return LinkedHashMap<double, Object>.from(map);
      }
      if (targetValueType == 'string') {
        return LinkedHashMap<double, String>.from(map);
      }
      if (targetValueType == 'int') {
        return LinkedHashMap<double, int>.from(map);
      }
      if (targetValueType == 'double') {
        return LinkedHashMap<double, double>.from(map);
      }
      if (targetValueType == 'num') {
        return LinkedHashMap<double, num>.from(map);
      }
      if (targetValueType == 'bool') {
        return LinkedHashMap<double, bool>.from(map);
      }
      return LinkedHashMap<double, dynamic>.from(map);
    }
    if (targetKeyType == 'bool') {
      if (targetValueType == 'object') {
        return LinkedHashMap<bool, Object>.from(map);
      }
      if (targetValueType == 'string') {
        return LinkedHashMap<bool, String>.from(map);
      }
      if (targetValueType == 'int') {
        return LinkedHashMap<bool, int>.from(map);
      }
      if (targetValueType == 'double') {
        return LinkedHashMap<bool, double>.from(map);
      }
      if (targetValueType == 'num') {
        return LinkedHashMap<bool, num>.from(map);
      }
      if (targetValueType == 'bool') {
        return LinkedHashMap<bool, bool>.from(map);
      }
      return LinkedHashMap<bool, dynamic>.from(map);
    }

    if (targetValueType == 'object') {
      return LinkedHashMap<num, Object>.from(map);
    }
    if (targetValueType == 'string') {
      return LinkedHashMap<num, String>.from(map);
    }
    if (targetValueType == 'int') {
      return LinkedHashMap<num, int>.from(map);
    }
    if (targetValueType == 'double') {
      return LinkedHashMap<num, double>.from(map);
    }
    if (targetValueType == 'num') {
      return LinkedHashMap<num, num>.from(map);
    }
    if (targetValueType == 'bool') {
      return LinkedHashMap<num, bool>.from(map);
    }
    return LinkedHashMap<num, dynamic>.from(map);
  }
}
