import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

/// 反射工具类
class MirrorUtils {
  MirrorUtils._();

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

  /// 判断元素是否继承了序列化模型
  static bool isSerialize(Element? element) {
    if (element is InterfaceElement) {
      return element.allSupertypes
          .any((e) => e.toString().contains('ElSerializeModel'));
    }
    return false;
  }

  /// 使用递归深度遍历元素字段默认值
  static dynamic deepGetFieldValue(ConstantReader reader, [Element? element]) {
    if (reader.isNull) return null;

    if (element != null && isSerialize(element)) {
      final classInfo = element as ClassElement;
      final fields = MirrorUtils.filterFields(classInfo);
      String content = '';
      for (var field in fields) {
        content += "${field.name}: ${deepGetFieldValue(
          reader.read(field.name),
          field.type.element,
        )},";
      }
      return "${classInfo.name}($content)";
    }
    if (reader.isString) {
      return "'${reader.literalValue}'";
    }
    if (reader.isDouble || reader.isInt || reader.isBool) {
      return reader.literalValue;
    }
    if (reader.isList) {
      return (reader.listValue)
          .map((e) => deepGetFieldValue(ConstantReader(e), e.type?.element))
          .toList();
    }
    if (reader.isSet) {
      return (reader.setValue)
          .map((e) => deepGetFieldValue(ConstantReader(e), e.type?.element))
          .toSet();
    }
    if (reader.isMap) {
      return (reader.mapValue).map((k, v) => MapEntry(
            deepGetFieldValue(ConstantReader(k), k?.type?.element),
            deepGetFieldValue(ConstantReader(v), v?.type?.element),
          ));
    }

    return null;
  }
}
