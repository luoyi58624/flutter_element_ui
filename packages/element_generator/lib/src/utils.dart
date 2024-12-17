import 'package:analyzer/dart/element/element.dart';
import 'package:element_annotation/element_annotation.dart';
import 'package:source_gen/source_gen.dart';

const TypeChecker modelChecker = TypeChecker.fromRuntime(ElModel);
const TypeChecker debugChecker = TypeChecker.fromRuntime(ElDebug);

/// 反射工具类
class MirrorUtils {
  MirrorUtils._();

  /// 检查类名是否添加了 ElDebug 注解
  static bool hasDebug(ClassElement classElement) {
    return debugChecker.hasAnnotationOfExact(classElement);
  }

  /// 获取 class 默认的构造方法
  static ConstructorElement getDefaultConstructor(ClassElement classElement) {
    late ConstructorElement result;
    for (int i = 0; i < classElement.constructors.length; i++) {
      if (classElement.constructors[i].name.isEmpty) {
        result = classElement.constructors[i];
        break;
      }
    }
    return result;
  }

  /// 通过 ClassElement 访问原始 VariableElement 元素的目标字段，此函数会遍历 super 继承的祖先元素，
  /// 注意：仅遍历添加了 ElModel 注解的父类。
  static FieldElement? getField(
    ClassElement classElement,
    VariableElement varElement,
  ) {
    if (varElement is FieldFormalParameterElement) {
      return classElement.getField(varElement.name);
    } else if (varElement is SuperFormalParameterElement) {
      final supers = classElement.allSupertypes;
      for (var s in supers) {
        if (modelChecker.hasAnnotationOfExact(s.element)) {
          final classElement = s.element as ClassElement;
          if (classElement.getField(varElement.name) != null) {
            return classElement.getField(varElement.name);
          }
        }
      }
    }
    return null;
  }

  /// 字段过滤，实体类需要生成的字段代码不需要关心以下修饰符
  static bool _fieldFilter(FieldElement fieldInfo) {
    return !(fieldInfo.isSynthetic ||
        fieldInfo.isStatic ||
        fieldInfo.isLate ||
        fieldInfo.isConst);
  }

  /// 过滤掉实体类中不需要生成的字段
  static List<FieldElement> filterFields(ClassElement classInfo) {
    return classInfo.fields.where((e) => MirrorUtils._fieldFilter(e)).toList();
  }

  /// 判断元素是否实现了 [ElSerializeModel] 序列化模型
  static bool isSerializeModel(Element? element) {
    if (element is InterfaceElement) {
      return element.allSupertypes
          .any((e) => e.toString().contains('ElSerializeModel'));
    }
    return false;
  }

  /// 使用递归深度遍历元素字段默认值
  static dynamic deepGetFieldValue(ConstantReader reader,
      [Element? element, bool? requireConst]) {
    if (reader.isNull) return null;

    if (element != null && isSerializeModel(element)) {
      final classInfo = element as ClassElement;
      final fields = MirrorUtils.filterFields(classInfo);
      String content = '';
      for (var field in fields) {
        content += "${field.name}: ${deepGetFieldValue(
          reader.read(field.name),
          field.type.element,
          false,
        )},";
      }
      content = "${classInfo.name}($content)";
      if (requireConst == true) {
        content = "const $content";
      }
      return content;
    }
    if (reader.isString) {
      return "'${reader.literalValue}'";
    }
    if (reader.isDouble || reader.isInt || reader.isBool) {
      return reader.literalValue;
    }
    if (reader.isList) {
      return (reader.listValue)
          .map((e) => deepGetFieldValue(
              ConstantReader(e), e.type?.element, requireConst ?? true))
          .toList();
    }
    if (reader.isSet) {
      return (reader.setValue)
          .map((e) => deepGetFieldValue(
              ConstantReader(e), e.type?.element, requireConst ?? true))
          .toSet();
    }
    if (reader.isMap) {
      return (reader.mapValue).map((k, v) => MapEntry(
            deepGetFieldValue(ConstantReader(k), k?.type?.element),
            deepGetFieldValue(
                ConstantReader(v), v?.type?.element, requireConst ?? true),
          ));
    }
    return null;
  }

  /// 生成字段的 lerp 函数
  static String generateFieldLerp(FieldElement fieldInfo) {
    String content = '';
    final fieldName = fieldInfo.name;
    final fieldType = fieldInfo.type.toString().replaceAll('?', '');
    if (fieldInfo.type.isDartCoreDouble) {
      content +=
          "$fieldName: lerpDouble(a.$fieldName, b.$fieldName, t) ?? a.$fieldName,";
    } else if (_hasLerp(fieldInfo)) {
      content +=
          "$fieldName: $fieldType.lerp(a.$fieldName, b.$fieldName, t) ?? a.$fieldName,";
    } else {
      content += "$fieldName: t < 0.5 ? a.$fieldName : b.$fieldName,";
    }

    return content;
  }
}

bool _hasLerp(FieldElement fieldInfo) {
  final fieldElement = fieldInfo.type.element;
  if (fieldElement is ClassElement && fieldElement.getMethod('lerp') != null) {
    return true;
  }
  return false;
}
