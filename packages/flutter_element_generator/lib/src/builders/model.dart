import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_generator/src/utils/common.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker _modelChecker = TypeChecker.fromRuntime(ElModel);
const TypeChecker _modelFieldChecker = TypeChecker.fromRuntime(ElModelField);

@immutable
class ElModelGenerator extends GeneratorForAnnotation<ElModel> {
  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final classInfo = element as ClassElement;
    final className = classInfo.name;

    String result = """
${generateFromJson(element, annotation)}  
    
extension ${className}Extension on $className {
  ${generateToJson(element, annotation)}
  ${generateCopyWidth(element, annotation)}
  ${generateMerge(element, annotation)}
  ${generateToString(element, annotation)}
}
  """;
    return result;
  }

  /// 生成 fromJson 方法
  String generateFromJson(Element element, ConstantReader annotation) {
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
        String? jsonKey = _getJsonKeyField(fieldInfo);
        String fieldType = fieldInfo.type.toString();
        // 如果用户指定了 json key，那么直接使用它，否则
        if (jsonKey != null) {
          content += '$field: json[\'$jsonKey\'] as $fieldType,\n';
        } else if (field == field.toLowerCase()) {
          content += '$field: json[\'$field\'] as $fieldType,\n';
        } else {
          content +=
              '$field: (json[\'$field\'] ?? json[\'${CommonUtil.toUnderline(field)}\']) as $fieldType,\n';
        }
      }
    }

    return """
$className _fromJson${fromJsonDiff ? className : ''}(Map<String, dynamic> json) => $className(
      $content
    );
    """;
  }

  /// 生成 toJson 方法
  String generateToJson(Element element, ConstantReader annotation) {
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
        String? jsonKey = _getJsonKeyField(fieldInfo);
        content += '\'${jsonKey ?? field}\': $field,\n';
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

  /// 生成 copyWith 拷贝方法
  String generateCopyWidth(Element element, ConstantReader annotation) {
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

  /// 生成 merge 合并对象方法
  String generateMerge(Element element, ConstantReader annotation) {
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

  /// 生成 toString 方法
  String generateToString(Element element, ConstantReader annotation) {
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
}

/// 判断字段是否允许 copy
bool _allowCopy(FieldElement fieldInfo) {
  return !(fieldInfo.isSynthetic ||
      fieldInfo.isStatic ||
      fieldInfo.isLate ||
      fieldInfo.isConst);
}

/// 判断当前字段是否被忽略
/// * typeString 生成的函数类型字符串，根据此字符串获取当前字段声明的注解参数，
/// 如果为true，则表示此函数生成的代码应当忽略该字段
bool _isIgnoreField(String typeString, FieldElement fieldInfo) {
  bool isElModelField = _modelFieldChecker.hasAnnotationOfExact(fieldInfo);
  if (isElModelField) {
    var target = _modelFieldChecker
        .firstAnnotationOfExact(fieldInfo)!
        .getField('ignore')!;
    return target.getField(typeString)?.toBoolValue() ?? false;
  }
  return false;
}

/// 获取当前字段配置的 jsonKey，如果为空则表示用户没有指定 jsonKey
String? _getJsonKeyField(FieldElement fieldInfo) {
  bool isElModelField = _modelFieldChecker.hasAnnotationOfExact(fieldInfo);
  if (isElModelField) {
    var value = _modelFieldChecker
        .firstAnnotationOfExact(fieldInfo)!
        .getField('jsonKey')
        ?.toStringValue();
    return value;
  }
  return null;
}

/// 判断反射的字段是否包含克隆方法，如果包含，则生成的代码需要调用目标的克隆方法
bool _isDeepCloneField(FieldElement fieldInfo) {
  final fieldElement = fieldInfo.type.element;
  if (fieldElement is ClassElement) {
    // 判断当前字段类型是否声明了 ElModel 注解，如果声明了 merge 方法，则属于深克隆字段
    bool isElModelField = _modelChecker.hasAnnotationOfExact(fieldElement);
    if (isElModelField) {
      return _modelChecker
          .firstAnnotationOfExact(fieldElement)!
          .getField('merge')!
          .toBoolValue() ??
          false;
    }
    // 判断当前字段类型是否包含了 merge 方法
    if (fieldElement.methods.map((method) => method.name).contains('merge')) {
      return true;
    }
  }
  return false;
}