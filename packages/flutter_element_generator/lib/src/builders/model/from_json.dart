part of './index.dart';

/// 生成 fromJson 方法
String _generateFromJson(Element element, ConstantReader annotation) {
  if (!annotation.read('formJson').boolValue) return '';

  final classInfo = element as ClassElement;
  final className = classInfo.name;
  final List<FieldElement> classFields = classInfo.fields;
  final fromJsonDiff = annotation.read('fromJsonDiff').boolValue;

  String content = '';

  for (int i = 0; i < classFields.length; i++) {
    final fieldInfo = classFields[i].declaration;
    if (_allowCopy(fieldInfo)) {
      if (_isIgnoreField('fromJson', fieldInfo)) {
        continue;
      }
      String field = fieldInfo.name;
      if (field == field.toLowerCase()) {
        content +=
            '$field: json[\'$field\'] as ${fieldInfo.type.toString()},\n';
      } else {
        content +=
            '$field: (json[\'$field\'] ?? json[\'${CommonUtil.toUnderline(field)}\']) as ${fieldInfo.type.toString()},\n';
      }
    }
  }

  return """
$className _fromJson${fromJsonDiff ? className : ''}(Map<String, dynamic> json) => $className(
      $content
    );
    """;
}
