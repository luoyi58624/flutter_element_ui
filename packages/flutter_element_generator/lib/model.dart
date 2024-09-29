import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

const _modelChecker = TypeChecker.fromRuntime(ElModel);
const _modelFieldChecker = TypeChecker.fromRuntime(ElModelField);

/// Element 组件命名前缀
const String _prefix = 'El';

/// Element 组件主题数据后缀
const String _suffix = 'ThemeData';

@immutable
class ElModelGenerator extends GeneratorForAnnotation<ElModel> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classInfo = element as ClassElement;
    final className = classInfo.name;
    final List<FieldElement> classFields = classInfo.fields;
    final rawName = getRawName(className);

    bool createFormJson = annotation.read('formJson').boolValue;
    bool createToJson = annotation.read('toJson').boolValue;
    bool createCopyWith = annotation.read('copyWith').boolValue;
    bool createMerge = annotation.read('merge').boolValue;
    bool createToString = annotation.read('generateToString').boolValue;
    bool createThemeWidget = annotation.read('themeWidget').boolValue;
    if (createMerge) createCopyWith = true;

    String result = """
extension ${className}Extension on $className {
  ${generateCopyWidth(createCopyWith, className, classFields)}
  ${generateMerge(createMerge, className, classFields)}
  ${generateToString(createToString, className, classFields)}
}
  """;

    if (createThemeWidget) {
      result += generateThemeWidget(createThemeWidget, rawName);
    }
    return result;
  }

  bool allowCopy(FieldElement fieldInfo) {
    return !(fieldInfo.isSynthetic ||
        fieldInfo.isStatic ||
        fieldInfo.isLate ||
        fieldInfo.isConst);
  }

  String generateCopyWidth(
      bool enable, String className, List<FieldElement> classFields) {
    if (!enable) return '';

    String copyWithArgument = '';
    String copyWithContent = '';

    for (int i = 0; i < classFields.length; i++) {
      final fieldInfo = classFields[i].declaration;
      if (allowCopy(fieldInfo)) {
        if (isIgnoreField('copyWith', fieldInfo)) continue;
        String fieldType = '${fieldInfo.type.toString().replaceAll('?', '')}?';
        String field = fieldInfo.name;
        copyWithArgument += '$fieldType $field,\n';

        if (isDeepCloneField(fieldInfo)) {
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

  String generateMerge(
      bool enable, String className, List<FieldElement> classFields) {
    if (!enable) return '';

    String mergeContent = '';

    for (int i = 0; i < classFields.length; i++) {
      FieldElement fieldInfo = classFields[i].declaration;
      if (allowCopy(fieldInfo)) {
        if (isIgnoreField('merge', fieldInfo)) continue;
        final field = fieldInfo.name;
        if (isDeepCloneField(fieldInfo)) {
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

  String generateToString(
      bool enable, String className, List<FieldElement> classFields) {
    if (!enable) return '';

    String toStringContent = '';

    for (int i = 0; i < classFields.length; i++) {
      if (classFields[i].declaration.isStatic == false) {
        final fieldInfo = classFields[i].declaration;
        if (isIgnoreField('generateToString', fieldInfo)) continue;
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

  String generateThemeWidget(bool enable, String rawName) {
    if (!enable) return '';
    return """
    
class $_prefix${rawName}Theme extends InheritedWidget {
  /// 局部默认样式小部件，你可以用来定义某个小部件的默认样式
  const $_prefix${rawName}Theme({super.key, required super.child, required this.data});

  final $_prefix$rawName$_suffix data;

  static $_prefix$rawName$_suffix? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<$_prefix${rawName}Theme>()?.data;
  }

  static $_prefix$rawName$_suffix of(BuildContext context, $_prefix$rawName$_suffix? data) {
    final result = maybeOf(context);
    assert(result != null, 'No $_prefix${rawName}Theme found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    $_prefix$rawName$_suffix? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = $_prefix${rawName}Theme.maybeOf(context) ?? context.elTheme.${rawName.substring(0, 1).toLowerCase() + rawName.substring(1)}Theme;
      return $_prefix${rawName}Theme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify($_prefix${rawName}Theme oldWidget) => true;
}
    """;
  }

  /// 过滤前缀和后缀，获取单纯的组件名字，例如：
  /// * ElButtonThemeData -> Button
  /// * ElLinkThemeData -> Link
  String getRawName(String className) {
    String rawName = className;
    if (rawName.startsWith(_prefix)) {
      rawName = rawName.substring(_prefix.length);
    }
    if (rawName.endsWith(_suffix)) {
      rawName = rawName.substring(0, rawName.lastIndexOf(_suffix));
    }
    return rawName;
  }

  /// 当前字段是否被忽略
  /// * typeString 生成的函数类型字符串，根据此字符串获取当前字段声明的注解参数，
  /// 如果为true，则表示此函数生成的代码应当忽略该字段
  bool isIgnoreField(String typeString, FieldElement fieldInfo) {
    bool isElModelField = _modelFieldChecker.hasAnnotationOfExact(fieldInfo);
    if (isElModelField) {
      var target = _modelFieldChecker
          .firstAnnotationOfExact(fieldInfo)!
          .getField('ignore')!;
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
}
