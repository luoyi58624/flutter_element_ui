import 'package:element_dart/element_dart.dart';

import '../element_annotation.dart';

const String _formJsonErrorStart = '(error) ElModel fromJson: ';
const String _formJsonErrorEnd = '提示：此错误仅在开发环境下显示。';

/// 安全地访问 json 数据，此工具类只用于 [element_generator] 生成的代码
class $ElJsonUtil {
  $ElJsonUtil._();

  static dynamic _getJsonValue(dynamic json, String key) {
    return json[key] ?? json[key.toUnderline];
  }

  static String? $string(dynamic json, String key) {
    final value = _getJsonValue(json, key);
    if (value == null) return null;
    return value.toString();
  }

  static num? $num(dynamic json, String key) {
    final value = _getJsonValue(json, key);
    if (value == null) return null;
    return num.tryParse(value.toString());
  }

  static int? $int(dynamic json, String key) {
    final value = _getJsonValue(json, key);
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      final v = num.tryParse(value);
      return v?.toInt();
    }
    if (value is double) return value.toInt();
    return int.tryParse(value.toString());
  }

  static double? $double(dynamic json, String key) {
    final value = _getJsonValue(json, key);
    if (value == null) return null;
    if (value is double) return value;
    if (value is int || value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static bool? $bool(dynamic json, String key) {
    final value = _getJsonValue(json, key);
    if (value == null) return null;
    return bool.tryParse(value.toString());
  }

  static List<T>? $list<T>(dynamic json, String key) {
    final value = _getJsonValue(json, key);
    if (value is List) {
      try {
        return List<T>.from(value);
      } catch (e) {
        if (!isRelease) {
          throw '$_formJsonErrorStart: $key -> List<${T.toString()}> 类型转换失败, '
              'json data: \n'
              '================================================================\n'
              '$value\n'
              '================================================================\n'
              '$_formJsonErrorEnd';
        }
      }
    }
    return null;
  }

  static Set<T>? $set<T>(dynamic json, String key) {
    final value = _getJsonValue(json, key);
    if (value is Iterable) {
      try {
        return Set<T>.from(value);
      } catch (e) {
        if (!isRelease) {
          throw '$_formJsonErrorStart: $key -> List<${T.toString()}> 类型转换失败, '
              'json data: \n'
              '================================================================\n'
              '$value\n'
              '================================================================\n'
              '$_formJsonErrorEnd';
        }
      }
    }
    return null;
  }

  static Map<String, T>? $map<T>(dynamic json, String key) {
    final value = _getJsonValue(json, key);
    if (value is Map) {
      try {
        return Map<String, T>.from(value);
      } catch (e) {
        if (!isRelease) {
          throw '$_formJsonErrorStart: $key -> Map<String, ${T.toString()}> 类型转换失败, '
              'json data: \n'
              '================================================================\n'
              '$value\n'
              '================================================================\n'
              '$_formJsonErrorEnd';
        }
      }
    }
    return null;
  }

  static T? $model<T>(dynamic json, String key, T model) {
    final value = _getJsonValue(json, key);
    if (value == null) return null;
    if (model is SerializeModel) {
      return model.fromJson(value);
    }
    return null;
  }

  /// 当内置的数据转换不满足目标类型时，将统一进入自定义序列化方法，
  /// 如果用户没有提供自定义序列化，那么程序将抛出异常
  static T? $custom<T>(dynamic json, String key, Serialize<T> model) {
    final value = _getJsonValue(json, key);
    if (value == null) return null;
    return model.deserialize(value);
  }

  static bool eqList(List? value1, List? value2) {
    if (value1 == null && value2 == null) return true;
    return value1!.eq(value2!);
  }

  static bool eqSet(Set? value1, Set? value2) {
    if (value1 == null && value2 == null) return true;
    return value1!.eq(value2!);
  }

  static bool eqMap(Map? value1, Map? value2) {
    if (value1 == null && value2 == null) return true;
    return value1!.eq(value2!);
  }
}
