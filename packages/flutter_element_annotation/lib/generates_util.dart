const _isDebug = bool.fromEnvironment("dart.vm.product") == false;
const String _formJsonErrorStart = '(error) ElModel fromJson: ';
const String _formJsonErrorEnd = '提示：此错误仅在开发环境下显示，如果你的 json 数据来源来自网络，'
    '请尽量使用 dynamic 类型。';

/// flutter_element_generator 代码生成工具类，此工具类只应用于生成的代码
class $ElGeneratesUtil {
  $ElGeneratesUtil._();

  static String? safeString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  static num? safeNum(dynamic value) {
    if (value == null) return null;
    return num.tryParse(value.toString());
  }

  static int? safeInt(dynamic value) {
    if (value == null) return null;
    return int.tryParse(value.toString());
  }

  static double? safeDouble(dynamic value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }

  static bool? safeBool(dynamic value) {
    if (value == null) return null;
    return bool.tryParse(value.toString());
  }

  static List<T>? safeList<T>(
    dynamic value,
    String className,
    String fieldName,
  ) {
    if (value is List) {
      try {
        return List<T>.from(value);
      } catch (e) {
        if (_isDebug) {
          throw '$_formJsonErrorStart: $className -> $fieldName -> List<${T.toString()}> 类型转换失败, '
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

  static Map<String, T>? safeMap<T>(
    dynamic value,
    String className,
    String fieldName,
  ) {
    if (value is Map) {
      try {
        return Map<String, T>.from(value);
      } catch (e) {
        if (_isDebug) {
          throw '$_formJsonErrorStart: $className -> $fieldName -> Map<String, ${T.toString()}> 类型转换失败, '
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
