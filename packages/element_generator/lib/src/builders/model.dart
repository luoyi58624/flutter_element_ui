import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../config.dart';
import '../utils.dart';

const TypeChecker _modelChecker = TypeChecker.fromRuntime(ElModel);
const TypeChecker _fieldChecker = TypeChecker.fromRuntime(ElField);

/// 当前实体类的信息
late ClassElement _classInfo;

/// 当前实体类的类名
late String _className;

/// 当前实体类的字段列表
late List<FieldElement> _classFields;

/// 当前实体类的默认构造函数是否使用 const 修饰
late bool _isConstConstructor;

@immutable
class ElModelGenerator extends GeneratorForAnnotation<ElModel> {
  @override
  generateForAnnotatedElement(element, annotation, buildStep) {
    _classInfo = element as ClassElement;
    _className = _classInfo.name;
    _classFields = MirrorUtils.filterFields(_classInfo);

    for (var constructor in _classInfo.constructors) {
      if (constructor.name.isEmpty) {
        _isConstConstructor = constructor.isConst;
      }
    }
    String result = """
${generateFromJson(annotation)}  
    
extension ${_className}Extension on $_className {
  ${generateToJson(annotation)}
  ${generateCopyWidth(annotation)}
  ${generateMerge(annotation)}
  ${generateEquals(annotation)}
  ${generateHashCode(annotation)}
  ${generateToString(annotation)}
}
  """;

    return result;
  }

  /// 生成 fromJson 方法
  String generateFromJson(ConstantReader annotation) {
    if (!annotation.read('formJson').boolValue) return '';

    String content = '';
    String defaultModelContent = '';

    final fromJsonDiff = annotation.read('fromJsonDiff').boolValue;

    for (int i = 0; i < _classFields.length; i++) {
      final fieldInfo = _classFields[i].declaration;
      if (_isIgnoreField(fieldInfo, 'fromJson')) continue;
      String field = fieldInfo.name;
      String fieldType = fieldInfo.type.toString();
      String jsonKey = _getJsonKey(fieldInfo) ?? field;
      dynamic defaultValue = _getDefaultValue(fieldInfo);

      String valueContent = '';
      String? defaultModelValueContent;

      // 尽可能地安全处理 json 数据类型转换
      if (fieldType == 'String' || fieldType == 'String?') {
        valueContent = "\$ElJsonUtil.\$string(json, '$jsonKey')";
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
        valueContent = "\$ElJsonUtil.\$num(json, '$jsonKey')";
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
        valueContent = "\$ElJsonUtil.\$int(json, '$jsonKey')";
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
        valueContent = "\$ElJsonUtil.\$double(json, '$jsonKey')";
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
        valueContent = "\$ElJsonUtil.\$bool(json, '$jsonKey')";
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
            "\$ElJsonUtil.\$list<${fieldType.toGenericType}>(json, '$jsonKey')";
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
            "\$ElJsonUtil.\$set<${fieldType.toGenericType}>(json, '$jsonKey')";
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
            "\$ElJsonUtil.\$map<${fieldType.toMapGenericType?.value}>(json, '$jsonKey')";
        if (defaultValue != null) {
          valueContent = '$valueContent ?? $defaultValue';
          defaultModelValueContent = '$defaultValue';
        } else {
          if (fieldType.endsWith('?') == false) {
            valueContent = '$valueContent ?? {}';
            defaultModelValueContent = '{}';
          }
        }
      } else if (MirrorUtils.isSerializeModel(fieldInfo.type.element)) {
        final String modelName = builderConfig.modelNameTemplate.replaceFirst(
          '{{}}',
          fieldType.replaceAll(RegExp(r'(<.*>)|\?'), '').firstLowerCase,
        );
        valueContent =
            "\$ElJsonUtil.\$model<$fieldType>(json, '$jsonKey', $modelName)";

        if (defaultValue != null) {
          valueContent = '$valueContent ?? $defaultValue';
          defaultModelValueContent = '$defaultValue';
        } else {
          if (fieldType.endsWith('?') == false) {
            valueContent = "$valueContent ?? $modelName";
            defaultModelValueContent = modelName;
          }
        }
      } else {
        final serializeName = _getCustomSerialize(fieldInfo);
        if (serializeName == null) {
          throw 'fromJson Error: $field 序列化失败，请配置序列化注解';
        } else {
          valueContent =
              "\$ElJsonUtil.\$custom<$fieldType>(json, '$jsonKey', const $serializeName())";
          if (fieldType.endsWith('?') == false) {
            throw 'fromJson Error: $fieldType $field 为自定义序列化类型，生成器无法设置默认值、'
                '同时也无法访问配置的默认值，你必须添加可为空符号 ?';
          }
        }
      }

      content += '$field: $valueContent,\n';
      if (defaultModelValueContent != null) {
        defaultModelContent += '$field: $defaultModelValueContent,\n';
      }
    }

    String modelName = builderConfig.modelNameTemplate
        .replaceFirst('{{}}', _className.firstLowerCase);

    return """
/// 生成的全局默认实体类对象
${_isConstConstructor ? 'const' : 'final'} $_className $modelName = $_className(
  $defaultModelContent
);

/// 生成的 fromJson 方法，将 Map 对象转成实体类
$_className _fromJson${fromJsonDiff ? _className : ''}(Map<String, dynamic>? json) {
  if(json == null) return $modelName;
  return $_className(
    $content
  );
}
    """;
  }

  /// 生成 toJson 方法
  String generateToJson(ConstantReader annotation) {
    if (!annotation.read('toJson').boolValue) return '';

    String content = '';
    final toJsonUnderline = annotation.read('toJsonUnderline').boolValue;

    for (int i = 0; i < _classFields.length; i++) {
      final fieldInfo = _classFields[i].declaration;
      if (_isIgnoreField(fieldInfo, 'toJson')) continue;
      String field = fieldInfo.name;
      String fieldType = fieldInfo.type.toString();
      String? jsonKey = _getJsonKey(fieldInfo);

      String key =
          "'${jsonKey ?? (toJsonUnderline ? field.toUnderline : field)}'";
      late String value;
      if (MirrorUtils.isSerializeModel(fieldInfo.type.element)) {
        if (fieldType.endsWith('?')) field += '?';
        value = "$field.toJson()";
      } else {
        final serializeName = _getCustomSerialize(fieldInfo);
        if (serializeName == null) {
          value = field;
        } else {
          value = "const $serializeName().serialize($field)";
        }
      }
      content += '$key: $value,\n';
    }

    return """
  /// 生成的 toJson 方法，将实体类转成 Map 对象  
  Map<String, dynamic> _toJson() {
    return {
      $content
    };
  }
    """;
  }

  /// 生成 copyWith 拷贝方法
  String generateCopyWidth(ConstantReader annotation) {
    if (!(annotation.read('copyWith').boolValue ||
        annotation.read('merge').boolValue)) return '';

    String copyWithArgument = '';
    String copyWithContent = '';

    for (int i = 0; i < _classFields.length; i++) {
      final fieldInfo = _classFields[i].declaration;
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

    return """
  /// 接收一组可选参数，返回新的对象
  $_className copyWith({
    $copyWithArgument
  }) {
    return $_className(
      $copyWithContent
    );
  }
    """;
  }

  /// 生成 merge 合并对象方法
  String generateMerge(ConstantReader annotation) {
    if (!annotation.read('merge').boolValue) return '';

    String content = '';
    for (int i = 0; i < _classFields.length; i++) {
      FieldElement fieldInfo = _classFields[i].declaration;
      if (_isIgnoreField(fieldInfo, 'merge')) continue;
      final field = fieldInfo.name;
      content += '$field: other.$field,\n';
    }

    return """
  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  $_className merge([$_className? other]) {
    if (other == null) return this;
    return copyWith(
      $content
    );
  }
    """;
  }

  /// 生成 equals 方法
  String generateEquals(ConstantReader annotation) {
    if (!annotation.read('generateEquals').boolValue) return '';

    String content = '';

    for (int i = 0; i < _classFields.length; i++) {
      final fieldInfo = _classFields[i].declaration;
      if (_isIgnoreField(fieldInfo, 'generateEquals')) continue;
      final field = fieldInfo.name;
      if (fieldInfo.type.isDartCoreList) {
        content += '&& \$ElJsonUtil.eqList($field, other.$field)';
      } else if (fieldInfo.type.isDartCoreSet) {
        content += '&& \$ElJsonUtil.eqSet($field, other.$field)';
      } else if (fieldInfo.type.isDartCoreMap) {
        content += '&& \$ElJsonUtil.eqMap($field, other.$field)';
      } else {
        content += '&& $field == other.$field';
      }
    }

    return """
/// 生成的对象比较方法，它只支持 String、num、int、double、bool、List、Set、Map、Model 等类型，
/// 如果你的实体类还包含其他数据类型，那么比较方法将失去作用   
bool _equals(Object other) =>
      identical(this, other) ||
      other is $_className && runtimeType == other.runtimeType $content;
    """;
  }

  /// 生成 hashCode 方法
  String generateHashCode(ConstantReader annotation) {
    if (!annotation.read('generateHashCode').boolValue) return '';

    String content = '';

    for (int i = 0; i < _classFields.length; i++) {
      final fieldInfo = _classFields[i].declaration;
      if (_isIgnoreField(fieldInfo, 'generateHashCode')) continue;
      final field = fieldInfo.name;
      content += '$field.hashCode';
      if (i < _classFields.length - 1) {
        content += ' ^ ';
      }
    }

    return """
/// 生成的 hashCode 方法    
int get _hashCode => $content;
    """;
  }

  /// 生成 toString 方法
  String generateToString(ConstantReader annotation) {
    if (!annotation.read('generateToString').boolValue) return '';

    String content = '';

    for (int i = 0; i < _classFields.length; i++) {
      final fieldInfo = _classFields[i].declaration;
      if (_isIgnoreField(fieldInfo, 'generateToString')) continue;
      final field = fieldInfo.name;
      String toStringDot = '';
      if (i < _classFields.length - 1) toStringDot = ',';
      content += '  $field: \$$field$toStringDot\\n';
    }

    return """
/// 生成的 toString 方法    
String _toString() {
  return '$_className{\\n$content}';
} 
    """;
  }
}

/// 判断当前字段是否被忽略
/// * typeString 生成的函数类型字符串，根据此字符串获取当前字段声明的注解参数，
/// 如果为true，则表示此函数生成的代码应当忽略该字段
bool _isIgnoreField(FieldElement fieldInfo, String typeString) {
  bool isElModelField = _fieldChecker.hasAnnotationOfExact(fieldInfo);
  if (isElModelField) {
    var target =
        _fieldChecker.firstAnnotationOfExact(fieldInfo)!.getField('ignore')!;
    return target.getField(typeString)?.toBoolValue() ?? false;
  }
  return false;
}

/// 获取当前字段配置的 jsonKey，如果为空则表示用户没有指定 jsonKey
String? _getJsonKey(FieldElement fieldInfo) {
  bool isElModelField = _fieldChecker.hasAnnotationOfExact(fieldInfo);
  if (isElModelField) {
    var value = _fieldChecker
        .firstAnnotationOfExact(fieldInfo)!
        .getField('jsonKey')
        ?.toStringValue();
    return value;
  }
  return null;
}

/// 获取当前字段配置的 defaultValue，如果为空则表示用户没有指定 defaultValue
dynamic _getDefaultValue(FieldElement fieldInfo) {
  bool isElModelField = _fieldChecker.hasAnnotationOfExact(fieldInfo);
  if (isElModelField) {
    var field = _fieldChecker
        .firstAnnotationOfExact(fieldInfo)!
        .getField('defaultValue');

    return MirrorUtils.deepGetFieldValue(
        ConstantReader(field), fieldInfo.type.element, true);
  }
  return null;
}

/// 判断反射的字段是否包含克隆方法，如果包含，则生成的代码需要调用目标的克隆方法
bool _isDeepCloneField(FieldElement fieldInfo) {
  final fieldElement = fieldInfo.type.element;
  if (fieldElement is ClassElement) {
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

/// 获取自定义序列化的注解名字
String? _getCustomSerialize(FieldElement fieldInfo) {
  if (fieldInfo.metadata.isEmpty) return null;
  ElementAnnotation? serializeMeta;
  for (final meta in fieldInfo.metadata) {
    if (meta.element is ConstructorElement) {
      var flag = (meta.element as ConstructorElement)
          .enclosingElement
          .allSupertypes
          .any((e) => e.toString().contains('ElSerialize'));

      if (flag) {
        serializeMeta = meta;
      }
    }
  }
  if (serializeMeta == null) return null;
  return serializeMeta.element!.displayName;
}
