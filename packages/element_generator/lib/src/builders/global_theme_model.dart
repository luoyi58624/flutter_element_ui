import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:element_generator/src/builders/theme_model.dart';
import 'package:element_generator/src/config.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../utils.dart';

@immutable
class ElGlobalThemeModelGenerator
    extends GeneratorForAnnotation<$ElGlobalThemeModel> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classInfo = element as ClassElement;
    final className = classInfo.name;
    final globalThemeClassName = themeModelBuilderConfig.globalThemeClassName;
    final classFields = MirrorUtils.filterFields(classInfo);

    String fieldContent = "";
    String lightConstruction = "";
    String darkConstruction = "";

    for (final field in classFields) {
      lightConstruction += 'super.${field.name},';
      darkConstruction += 'super.${field.name},';
    }
    for (final model in ElThemeModelGenerator.themeModelList) {
      final rawName = ElThemeModelGenerator.getRawName(model.name);
      final themeVarName = '${rawName.firstLowerCase}Theme';
      String $fieldContent = "final ${model.name} $themeVarName;";
      if (model.desc != '') {
        $fieldContent = """
        /// ${model.desc} 
        ${$fieldContent}
        """;
      }
      fieldContent += $fieldContent;
      lightConstruction += "this.$themeVarName = ${model.name}.theme,";
      darkConstruction += "this.$themeVarName = ${model.name}.darkTheme,";
    }
    return """
class $globalThemeClassName extends $className {
  /// 亮色默认主题
  static const $globalThemeClassName theme = $globalThemeClassName();
  
  /// 暗色默认主题
  static const $globalThemeClassName darkTheme = $globalThemeClassName.dark();
  
  $fieldContent
  
  const $globalThemeClassName({
    $lightConstruction
  });
  
  const $globalThemeClassName.dark({
    $darkConstruction
  }) : super.dark();
}
    """;
  }
}
