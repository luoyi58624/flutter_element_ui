import 'package:flutter_element_dart/flutter_element_dart.dart';

const String _formJsonErrorStart = '(error) ElModel fromJson: ';
const String _formJsonErrorEnd = '提示：此错误仅在开发环境下显示，如果你的 json 数据来源来自网络，'
    '请尽量使用 dynamic 类型。';

/// 安全地访问 json 数据，此工具类通常应用于 [flutter_element_generator] 生成的代码
class ElJsonUtil {
  ElJsonUtil._();

  static String? $string(dynamic json, String key) {
    final value = json[key] ?? json[key.toUnderline];
    if (value == null) return null;
    return value.toString();
  }

  static num? $num(dynamic json, String key) {
    final value = json[key] ?? json[key.toUnderline];
    if (value == null) return null;
    return num.tryParse(value.toString());
  }

  static int? $int(dynamic json, String key) {
    final value = json[key] ?? json[key.toUnderline];
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
    final value = json[key] ?? json[key.toUnderline];
    if (value == null) return null;
    if (value is double) return value;
    if (value is int || value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static bool? $bool(dynamic json, String key) {
    final value = json[key] ?? json[key.toUnderline];
    if (value == null) return null;
    return bool.tryParse(value.toString());
  }

  static List<T>? $list<T>(dynamic json, String key) {
    final value = json[key] ?? json[key.toUnderline];
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
    final value = json[key] ?? json[key.toUnderline];
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
    final value = json[key] ?? json[key.toUnderline];
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
}
