/// 序列化模型接口
abstract interface class ElSerialize {
  /// 将 json 转成模型对象
  ElSerialize fromJson(Map<String, dynamic> json);

  /// 将模型对象转成 json
  Map<String, dynamic> toJson();
}

/// Element UI 序列化工具类，封装一些类型转换函数
class ElSerializeUtil {
  ElSerializeUtil._();

  static const _isDebug = bool.fromEnvironment("dart.vm.product") == false;

  static const String _formJsonErrorStart = '(error) ElModel fromJson: ';
  static const String _formJsonErrorEnd =
      'Tip：this error only show in dev env.';

  /// 安全地转换 List 集合
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
          throw '$_formJsonErrorStart: $className -> $fieldName -> List<${T.toString()}> type conversion failed, '
              'json data is: \n'
              '================================================================\n'
              '$value\n'
              '================================================================\n'
              '$_formJsonErrorEnd';
        }
      }
    }
    return null;
  }

  /// 安全地转换 Map 集合，注意：Map 的 key 必须强制为 String 类型
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
          throw '$_formJsonErrorStart: $className -> $fieldName -> Map<String, ${T.toString()}> type conversion failed, '
              'json data is: \n'
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
