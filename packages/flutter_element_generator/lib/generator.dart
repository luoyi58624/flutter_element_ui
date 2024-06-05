import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@immutable
class ElModelGenerator extends GeneratorForAnnotation<ElModel> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final classInfo = element as ClassElement;
    final className = classInfo.name;
    final List<FieldElement> classFields = classInfo.fields;

    bool createFormJson = annotation.read('formJson').boolValue;
    bool createToJson = annotation.read('toJson').boolValue;
    bool createCopyWith = annotation.read('copyWith').boolValue;
    bool createMerge = annotation.read('merge').boolValue;
    bool createToString = annotation.read('createToString').boolValue;
    if (createMerge) createCopyWith = true;

    return """
extension ${className}Extension on $className {
  ${generateCopyWidth(createCopyWith, className, classFields)}
  ${generateMerge(createMerge, className, classFields)}
  ${generateToString(createToString, className, classFields)}
}
  """;
  }

  String generateCopyWidth(bool enable, String className, List<FieldElement> classFields) {
    if (!enable) return '';

    String copyWithArgument = '';
    String copyWithContent = '';

    for (int i = 0; i < classFields.length; i++) {
      if (classFields[i].declaration.isStatic == false) {
        final fieldInfo = classFields[i].declaration;
        copyWithArgument += '${fieldInfo.toString()},\n';
        String field = fieldInfo.name;
        if (isDeepCloneField(fieldInfo)) {
          copyWithContent += '$field: this.$field?.merge($field),';
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

  String generateMerge(bool enable, String className, List<FieldElement> classFields) {
    if (!enable) return '';

    String mergeContent = '';

    for (int i = 0; i < classFields.length; i++) {
      if (classFields[i].declaration.isStatic == false) {
        final fieldInfo = classFields[i].declaration;
        final field = fieldInfo.name;
        if (isDeepCloneField(fieldInfo)) {
          mergeContent += '$field: $field?.merge(style.$field),';
        } else {
          mergeContent += '$field: style.$field,\n';
        }
      }
    }

    return """
  $className merge([$className? style]) {
    if (style == null) return this;
    return copyWith(
      $mergeContent
    );
  }
    """;
  }

  String generateToString(bool enable, String className, List<FieldElement> classFields) {
    if (!enable) return '';

    String toStringContent = '';

    for (int i = 0; i < classFields.length; i++) {
      if (classFields[i].declaration.isStatic == false) {
        final field = classFields[i].declaration.name;
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

  /// 判断反射的字段是否包含克隆方法，如果包含，需要调用目标的克隆方法
  bool isDeepCloneField(FieldElement fieldInfo) {
    bool isDeepClone = false;
    final fieldElement = fieldInfo.type.element;
    if (fieldElement is ClassElement) {
      if (fieldElement.methods.map((method) => method.name).contains('merge')) {
        isDeepClone = true;
      }
    }
    return isDeepClone;
  }
}
