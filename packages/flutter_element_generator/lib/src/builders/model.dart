import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:flutter_element_dart/flutter_element_dart.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../config.dart';

const TypeChecker _modelChecker = TypeChecker.fromRuntime(ElModel);
const TypeChecker _modelFieldChecker = TypeChecker.fromRuntime(ElModelField);

@immutable
class ElModelGenerator extends GeneratorForAnnotation<ElModel> {
  final BuilderConfig config;

  ElModelGenerator(this.config);

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

    // 生成 fromJson 内容
    String content = '';

    // 生成默认模型对象内容
    String defaultModelContent = '';

    for (int i = 0; i < classFields.length; i++) {
      final fieldInfo = classFields[i].declaration;
      if (_allowCopy(fieldInfo)) {
        if (_isIgnoreField(fieldInfo, 'fromJson')) continue;
        String field = fieldInfo.name;
        String fieldType = fieldInfo.type.toString();
        String jsonKey = _getJsonKey(fieldInfo) ?? field;
        dynamic defaultValue = _getDefaultValue(fieldInfo);

        // 拼接 fromJson
        String valueContent = '';

        // 拼接默认的实体对象
        String? defaultModelValueContent;

        // 尽可能地安全处理 json 数据类型转换
        if (fieldType == 'String' || fieldType == 'String?') {
          valueContent = "ElJsonUtil.\$string(json, '$jsonKey')";
          if (defaultValue != null) {
            valueContent = '$valueContent ?? $defaultValue';
            defaultModelValueContent = '$defaultValue';
          } else {
            if (fieldType == 'String') {
              valueContent = '$valueContent ?? \'\'';
              defaultModelValueContent = '\'\'';
            }
          }
        } else if (fieldType == 'num' || fieldType == 'num?') {
          valueContent = "ElJsonUtil.\$num(json, '$jsonKey')";
          if (defaultValue != null) {
            valueContent = '$valueContent ?? $defaultValue';
            defaultModelValueContent = '$defaultValue';
          } else {
            if (fieldType == 'num') {
              valueContent = '$valueContent ?? 0.0';
              defaultModelValueContent = '0.0';
            }
          }
        } else if (fieldType == 'int' || fieldType == 'int?') {
          valueContent = "ElJsonUtil.\$int(json, '$jsonKey')";
          if (defaultValue != null) {
            valueContent = '$valueContent ?? $defaultValue';
            defaultModelValueContent = '$defaultValue';
          } else {
            if (fieldType == 'int') {
              valueContent = '$valueContent ?? 0';
              defaultModelValueContent = '0';
            }
          }
        } else if (fieldType == 'double' || fieldType == 'double?') {
          valueContent = "ElJsonUtil.\$double(json, '$jsonKey')";
          if (defaultValue != null) {
            valueContent = '$valueContent ?? $defaultValue';
            defaultModelValueContent = '$defaultValue';
          } else {
            if (fieldType == 'double') {
              valueContent = '$valueContent ?? 0.0';
              defaultModelValueContent = '0.0';
            }
          }
        } else if (fieldType == 'bool' || fieldType == 'bool?') {
          valueContent = "ElJsonUtil.\$bool(json, '$jsonKey')";
          if (defaultValue != null) {
            valueContent = '$valueContent ?? $defaultValue';
            defaultModelValueContent = '$defaultValue';
          } else {
            if (fieldType == 'bool') {
              valueContent = '$valueContent ?? false';
              defaultModelValueContent = 'false';
            }
          }
        } else if (fieldInfo.type.isDartCoreList) {
          valueContent =
              "ElJsonUtil.\$list<${fieldType.toGenericType}>(json, '$jsonKey')";
          if (defaultValue != null) {
            valueContent = '$valueContent ?? $defaultValue';
            defaultModelValueContent = '$defaultValue';
          } else {
            if (fieldType.endsWith('?') == false) {
              valueContent = '$valueContent ?? []';
              defaultModelValueContent = '[]';
            }
          }
        } else if (fieldInfo.type.isDartCoreSet) {
          valueContent =
              "ElJsonUtil.\$set<${fieldType.toGenericType}>(json, '$jsonKey')";
          if (defaultValue != null) {
            valueContent = '$valueContent ?? $defaultValue';
            defaultModelValueContent = '$defaultValue';
          } else {
            if (fieldType.endsWith('?') == false) {
              valueContent = '$valueContent ?? {}';
              defaultModelValueContent = '{}';
            }
          }
        } else if (fieldInfo.type.isDartCoreMap) {
          valueContent =
              "ElJsonUtil.\$map<${fieldType.toMapGenericType?.value}>(json, '$jsonKey')";
          if (defaultValue != null) {
            valueContent = '$valueContent ?? $defaultValue';
            defaultModelValueContent = '$defaultValue';
          } else {
            if (fieldType.endsWith('?') == false) {
              valueContent = '$valueContent ?? {}';
              defaultModelValueContent = '{}';
            }
          }
        } else {
          if (_isSerializeField(fieldInfo)) {
            if (jsonKey == jsonKey.toLowerCase()) {
              valueContent = "json['$jsonKey']";
            } else {
              valueContent =
                  "(json['$jsonKey'] ?? json['${jsonKey.toUnderline}'])";
            }

            final String modelName =
                config.modelNameTemplate.replaceFirst('{{}}', field);

            valueContent = "$modelName.fromJson($valueContent)";
            defaultModelValueContent = modelName;
          }
        }

        content += '$field: $valueContent,\n';
        if (defaultModelValueContent != null) {
          defaultModelContent += '$field: $defaultModelValueContent,\n';
        }
      }
    }

    String modelName =
        config.modelNameTemplate.replaceFirst('{{}}', className.firstLowerCase);

    return """
final $className $modelName = $className(
  $defaultModelContent
);

$className _fromJson${fromJsonDiff ? className : ''}(Map<String, dynamic>? json) {
  if(json == null) return $modelName;
  return $className(
    $content
  );
}
    """;
  }

  /// 生成 toJson 方法
  String generateToJson(Element element, ConstantReader annotation) {
    if (!annotation.read('toJson').boolValue) return '';

    final classInfo = element as ClassElement;
    final List<FieldElement> classFields = classInfo.fields;
    final toJsonUnderline = annotation.read('toJsonUnderline').boolValue;

    String content = '';

    for (int i = 0; i < classFields.length; i++) {
      final fieldInfo = classFields[i].declaration;
      if (_allowCopy(fieldInfo)) {
        if (_isIgnoreField(fieldInfo, 'toJson')) continue;
        String field = fieldInfo.name;
        String fieldType = fieldInfo.type.toString();
        String? jsonKey = _getJsonKey(fieldInfo);

        String key =
            "'${jsonKey ?? (toJsonUnderline ? field.toUnderline : field)}'";
        late String value;
        if (_isSerializeField(fieldInfo)) {
          if (fieldType.endsWith('?')) field += '?';
          value = "$field.toJson()";
        } else {
          value = field;
        }
        content += '$key: $value,\n';
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
        if (_isIgnoreField(fieldInfo, 'copyWith')) continue;
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
        if (_isIgnoreField(fieldInfo, 'merge')) continue;
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
        if (_isIgnoreField(fieldInfo, 'generateToString')) continue;
        final field = fieldInfo.name;
        String toStringDot = '';
        if (i < classFields.length - 1) toStringDot = ',';
        toStringContent += '  $field: \$$field$toStringDot\\n';
      }
    }

    return """
String _toString() {
  return '$className{\\n$toStringContent}';
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

/// 判断字段是否为继承了序列化模型对象字段
bool _isSerializeField(FieldElement fieldInfo) {
  if (fieldInfo.type.element is InterfaceElement) {
    final ele = fieldInfo.type.element as InterfaceElement;
    return ele.allSupertypes
        .any((e) => e.toString().contains('ElSerializeModel'));
  }
  return false;
}

/// 判断当前字段是否被忽略
/// * typeString 生成的函数类型字符串，根据此字符串获取当前字段声明的注解参数，
/// 如果为true，则表示此函数生成的代码应当忽略该字段
bool _isIgnoreField(FieldElement fieldInfo, String typeString) {
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
String? _getJsonKey(FieldElement fieldInfo) {
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

/// 获取当前字段配置的 defaultValue，如果为空则表示用户没有指定 defaultValue
dynamic _getDefaultValue(FieldElement fieldInfo) {
  bool isElModelField = _modelFieldChecker.hasAnnotationOfExact(fieldInfo);
  if (isElModelField) {
    var field = _modelFieldChecker
        .firstAnnotationOfExact(fieldInfo)!
        .getField('defaultValue');

    return _deepGetDefaultValue(field);
  }
  return null;
}

/// 使用递归深度遍历默认值
dynamic _deepGetDefaultValue(DartObject? field) {
  if (field == null || field.isNull) return null;
  final reader = ConstantReader(field);
  dynamic value;
  if (reader.isString) {
    return "'${reader.literalValue}'";
  }
  if (reader.isDouble || reader.isInt || reader.isBool) {
    return reader.literalValue;
  }
  if (reader.isList) {
    value = (field.toListValue() ?? [])
        .map((e) => _deepGetDefaultValue(e))
        .toList();
    return value;
  }
  if (reader.isSet) {
    value =
        (field.toSetValue() ?? {}).map((e) => _deepGetDefaultValue(e)).toSet();
    return value;
  }
  if (reader.isMap) {
    value = (field.toMapValue() ?? {}).map((k, v) => MapEntry(
          _deepGetDefaultValue(k),
          _deepGetDefaultValue(v),
        ));
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
