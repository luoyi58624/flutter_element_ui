import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

/// Element 组件命名前缀
const String _prefix = 'El';

/// Element 组件主题数据后缀
const String _suffix = 'ThemeData';

@immutable
class ElThemeDataGenerator extends GeneratorForAnnotation<ElThemeDataModel> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classInfo = element as ClassElement;
    final className = classInfo.name;
    final rawName = _getRawName(className);

    bool generateInheritedWidget =
        annotation.read('generateInheritedWidget').boolValue;

    String result = """""";

    if (generateInheritedWidget) {
      result += generateThemeWidget(generateInheritedWidget, rawName);
    }
    return result;
  }

  String generateThemeWidget(bool enable, String rawName) {
    if (!enable) return '';
    String className = '$_prefix${rawName}Theme';
    String fieldName = '$_prefix$rawName$_suffix';
    return """
    
class $className extends InheritedWidget {
  const $className({super.key, required super.child, required this.data});

  /// 主题数据
  final $fieldName data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static $fieldName? maybeOf(BuildContext context) =>
     context.dependOnInheritedWidgetOfExactType<$className>()?.data;
  
  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static $fieldName of(BuildContext context) =>
     maybeOf(context) ?? context.elTheme.${rawName.firstLowerCase}Theme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    $fieldName? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = $className.of(context);
      return $className(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify($className oldWidget) => true;
}
    """;
  }
}

/// 过滤前缀和后缀，获取单纯的组件名字，例如：
/// * ElButtonThemeData -> Button
/// * ElLinkThemeData -> Link
String _getRawName(String className) {
  String rawName = className;
  if (rawName.startsWith(_prefix)) {
    rawName = rawName.substring(_prefix.length);
  }
  if (rawName.endsWith(_suffix)) {
    rawName = rawName.substring(0, rawName.lastIndexOf(_suffix));
  }
  return rawName;
}
