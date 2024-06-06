import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@immutable
class ElComponentGenerator extends GeneratorForAnnotation<ElComponent> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final classInfo = element as ClassElement;
    final className = classInfo.name;

    bool createTheme = annotation.read('theme').boolValue;
    bool createImportantTheme = annotation.read('importantTheme').boolValue;

    return """
${generateTheme(createTheme, className)}
${generateImportantTheme(createImportantTheme, className)}
  """;
  }

  String generateTheme(bool enable, String className) {
    if (!enable) return '';
    return """
class ${className}Theme extends InheritedWidget {
  /// 局部默认样式小部件，你可以用来定义某个小部件的默认样式
  const ${className}Theme({super.key, required super.child, required this.style});

  final ${className}Style style;

  static ${className}Style? _merge(BuildContext context, ${className}Style? style) {
    var defaultStyle = context.dependOnInheritedWidgetOfExactType<${className}Theme>()?.style;
    return defaultStyle == null ? style : defaultStyle.merge(style);
  }

  @override
  bool updateShouldNotify(${className}Theme oldWidget) => oldWidget.style != style;
}
    """;
  }

  String generateImportantTheme(bool enable, String className) {
    if (!enable) return '';
    return """
class ${className}ImportantTheme extends InheritedWidget {
  /// 强制后代小部件应用的主题样式，效果类似于 CSS !important
  const ${className}ImportantTheme({super.key, required super.child, required this.style});

  final ${className}Style style;

  static ${className}Style _merge(BuildContext context, ${className}Style style) =>
      style.merge(context.dependOnInheritedWidgetOfExactType<${className}ImportantTheme>()?.style);

  @override
  bool updateShouldNotify(${className}ImportantTheme oldWidget) => oldWidget.style != style;
}
    """;
  }
}
