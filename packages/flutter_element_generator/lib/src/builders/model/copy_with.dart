part of './index.dart';

/// 生成 copyWith 拷贝方法
String _generateCopyWidth(Element element, ConstantReader annotation) {
  if (!(annotation.read('copyWith').boolValue ||
      annotation.read('merge').boolValue)) return '';

  final classInfo = element as ClassElement;
  final className = classInfo.name;
  final List<FieldElement> classFields = classInfo.fields;
  String copyWithArgument = '';
  String copyWithContent = '';

  for (int i = 0; i < classFields.length; i++) {
    final fieldInfo = classFields[i].declaration;
    if (_allowCopy(fieldInfo)) {
      if (_isIgnoreField('copyWith', fieldInfo)) {
        continue;
      }
      String fieldType = '${fieldInfo.type.toString().replaceAll('?', '')}?';
      String field = fieldInfo.name;
      copyWithArgument += '$fieldType $field,\n';

      if (_isDeepCloneField(fieldInfo)) {
        bool isAllowNull = fieldInfo.type.toString().endsWith('?');
        copyWithContent +=
            '$field: this.$field${isAllowNull ? '?' : ''}.merge($field),';
      } else {
        copyWithContent += '$field: $field ?? this.$field,\n';
      }
    }
  }

  return """
  $className copyWith({
    $copyWithArgument
  }) {
    return $className(
      $copyWithContent
    );
  }
    """;
}
