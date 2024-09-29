part of './index.dart';

/// 生成 toString 方法
String _generateToString(Element element, ConstantReader annotation) {
  if (!annotation.read('generateToString').boolValue) return '';

  final classInfo = element as ClassElement;
  final className = classInfo.name;
  final List<FieldElement> classFields = classInfo.fields;

  String toStringContent = '';

  for (int i = 0; i < classFields.length; i++) {
    if (classFields[i].declaration.isStatic == false) {
      final fieldInfo = classFields[i].declaration;
      if (_isIgnoreField('generateToString', fieldInfo)) continue;
      final field = fieldInfo.name;
      String toStringDot = '';
      if (i < classFields.length - 1) toStringDot = ',';
      toStringContent += '$field: \$$field$toStringDot';
    }
  }

  return """
  String _toString() {
    return '$className{$toStringContent}';
  } 
    """;
}
