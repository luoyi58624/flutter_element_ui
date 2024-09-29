import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_generator/src/utils/common.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../utils/theme_data.dart';

@immutable
class ElThemeDataGenerator extends GeneratorForAnnotation<ElThemeDataModel> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classInfo = element as ClassElement;
    final className = classInfo.name;
    final rawName = ThemeDataUtil.getRawName(className);

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
    String className = '${ThemeDataUtil.prefix}${rawName}Theme';
    String fieldName = '${ThemeDataUtil.prefix}$rawName${ThemeDataUtil.suffix}';
    return """
    
class $className extends InheritedWidget {
  const $className({super.key, required super.child, required this.data});

  final $fieldName data;

  static $fieldName? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<$className>()?.data;
  }

  static $fieldName of(BuildContext context, $fieldName? data) {
    final result = maybeOf(context);
    assert(result != null, 'No $className found in context');
    return result!;
  }

  static Widget merge({
    Key? key,
    $fieldName? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = $className.maybeOf(context) ?? context.elTheme.${CommonUtil.firstLowerCase(rawName)}Theme;
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
