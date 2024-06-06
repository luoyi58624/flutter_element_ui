import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

const _modelChecker = TypeChecker.fromRuntime(ElModel);
const _modelFieldChecker = TypeChecker.fromRuntime(ElModelField);

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
      // 排除静态类型字段
      if (classFields[i].declaration.isStatic == false) {
        final fieldInfo = classFields[i].declaration;
        if (isIgnoreField('copyWith', fieldInfo)) continue;
        String fieldType = '${fieldInfo.type.toString().replaceAll('?', '')}?';
        String field = fieldInfo.name;
        copyWithArgument += '$fieldType $field,\n';

        if (isDeepCloneField(fieldInfo)) {
          bool isAllowNull = fieldInfo.type.toString().endsWith('?');
          copyWithContent += '$field: this.$field${isAllowNull ? '?' : ''}.merge($field),';
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
        if (isIgnoreField('copyWith', fieldInfo)) continue;
        final field = fieldInfo.name;
        if (isDeepCloneField(fieldInfo)) {
          mergeContent += '$field: $field?.merge(other.$field),';
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

  String generateToString(bool enable, String className, List<FieldElement> classFields) {
    if (!enable) return '';

    String toStringContent = '';

    for (int i = 0; i < classFields.length; i++) {
      if (classFields[i].declaration.isStatic == false) {
        final fieldInfo = classFields[i].declaration;
        if (isIgnoreField('copyWith', fieldInfo)) continue;
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

  /// 当前字段是否被忽略
  /// * typeString 生成的函数类型字符串，根据此字符串获取当前字段声明的注解参数，
  /// 如果为true，则表示此函数生成的代码应当忽略该字段
  bool isIgnoreField(String typeString, FieldElement fieldInfo) {
    bool isElModelField = _modelFieldChecker.hasAnnotationOfExact(fieldInfo);
    if (isElModelField) {
      var target = _modelFieldChecker.firstAnnotationOfExact(fieldInfo)!.getField('ignore')!;
      return target.getField(typeString)?.toBoolValue() ?? false;
    }
    return false;
  }

  /// 判断反射的字段是否包含克隆方法，如果包含，则生成的代码需要调用目标的克隆方法
  bool isDeepCloneField(FieldElement fieldInfo) {
    final fieldElement = fieldInfo.type.element;
    if (fieldElement is ClassElement) {
      // 判断当前字段类型是否声明了 ElModel 注解，如果声明了 merge 方法，则属于深克隆字段
      bool isElModelField = _modelChecker.hasAnnotationOfExact(fieldElement);
      if (isElModelField) {
        return _modelChecker.firstAnnotationOfExact(fieldElement)!.getField('merge')!.toBoolValue() ?? false;
      }
      // 判断当前字段类型是否包含了 merge 方法
      if (fieldElement.methods.map((method) => method.name).contains('merge')) {
        return true;
      }
    }
    return false;
  }
}
