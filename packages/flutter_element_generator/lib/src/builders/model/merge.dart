part of './index.dart';

/// 生成 merge 合并对象方法
String _generateMerge(Element element, ConstantReader annotation) {
  if (!annotation.read('merge').boolValue) return '';

  final classInfo = element as ClassElement;
  final className = classInfo.name;
  final List<FieldElement> classFields = classInfo.fields;

  String mergeContent = '';

  for (int i = 0; i < classFields.length; i++) {
    FieldElement fieldInfo = classFields[i].declaration;
    if (_allowCopy(fieldInfo)) {
      if (_isIgnoreField('merge', fieldInfo)) continue;
      final field = fieldInfo.name;
      if (_isDeepCloneField(fieldInfo)) {
        String fieldModifier = '';
        if (fieldInfo.type.nullabilitySuffix == NullabilitySuffix.question) {
          fieldModifier = '?';
        }
        mergeContent += '$field: $field$fieldModifier.merge(other.$field),';
      } else {
        mergeContent += '$field: other.$field,\n';
      }
    }
  }

  return """
  $className merge([$className? other]) {
    if (other == null) return this;
    return copyWith(
      $mergeContent
    );
  }
    """;
}
