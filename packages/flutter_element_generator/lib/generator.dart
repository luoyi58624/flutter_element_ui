import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

@immutable
class ElModelGenerator extends GeneratorForAnnotation<ElModel> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    var e = element as ClassElement;
    final className = e.name;
    String copyWithArgument = '';
    String copyWithContent = '';
    String mergeContent = '';
    String toStringContent = '';
    for (int i = 0; i < e.fields.length; i++) {
      if (e.fields[i].declaration.isStatic == false) {
        copyWithArgument += '${e.fields[i].declaration.toString()},\n';
        String field = e.fields[i].declaration.name;
        copyWithContent += '$field: $field ?? this.$field,\n';
        mergeContent += '$field: style.$field,\n';
        String toStringDot = '';
        if (i < e.fields.length - 1) toStringDot = ',';
        toStringContent += '$field: \$$field$toStringDot';
      }
    }
    return """
extension ${className}Extension on $className {
  $className copyWith({
    $copyWithArgument
  }) {
    return $className(
      $copyWithContent
    );
  }
  
  $className merge([$className? style]) {
    if (style == null) return this;
    return copyWith(
      $mergeContent
    );
  }
  
  String _toString() {
    return '$className{$toStringContent}';
  }  
}
  """;
  }
}
