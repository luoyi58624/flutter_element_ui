import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:build/build.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_generator/src/utils/common.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

part 'common.dart';

part 'from_json.dart';

part 'to_json.dart';

part 'copy_with.dart';

part 'merge.dart';

part 'to_string.dart';

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
${_generateFromJson(element, annotation)}  
    
extension ${className}Extension on $className {
  ${_generateToJson(element, annotation)}
  ${_generateCopyWidth(element, annotation)}
  ${_generateMerge(element, annotation)}
  ${_generateToString(element, annotation)}
}
  """;
    return result;
  }
}
