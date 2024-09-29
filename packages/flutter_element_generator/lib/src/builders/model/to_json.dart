part of './index.dart';

/// 生成 toJson 方法
String _generateToJson(Element element, ConstantReader annotation) {
  if (!annotation.read('toJson').boolValue) return '';

  final classInfo = element as ClassElement;
  final List<FieldElement> classFields = classInfo.fields;

  String content = '';

  for (int i = 0; i < classFields.length; i++) {
    final fieldInfo = classFields[i].declaration;
    if (_allowCopy(fieldInfo)) {
      if (_isIgnoreField('toJson', fieldInfo)) {
        continue;
      }
      String field = fieldInfo.name;
      content += '\'$field\': $field,\n';
    }
  }

  return """
  Map<String, dynamic> _toJson() {
    return {
      $content
    };
  }
    """;
}
