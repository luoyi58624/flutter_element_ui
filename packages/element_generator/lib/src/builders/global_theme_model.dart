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
    extends GeneratorForAnnotation<ElGlobalThemeModel> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classInfo = element as ClassElement;
    final className = classInfo.name;
    final globalThemeClassName = themeModelBuilderConfig.globalThemeClassName;
    final classFields = MirrorUtils.filterFields(classInfo);

    String fieldContent = "";
    String lightConstructionArgument = "";
    String lightConstructionContent = "";
    String darkConstructionArgument = "";
    String darkConstructionContent = "";
    String copyWithArgument = '';
    String copyWithContent = '';
    String mergeContent = '';

    for (final field in classFields) {
      lightConstructionArgument += 'super.${field.name},';
      darkConstructionArgument += 'super.${field.name},';
      copyWithArgument += '${field.type.toString()}? ${field.name},\n';
      copyWithContent +=
          '${field.name}: ${field.name} ?? super.${field.name},\n';
      mergeContent += '${field.name}: other.${field.name},\n';
    }
    for (final model in ElThemeModelGenerator.themeModelList) {
      final rawName = ElThemeModelGenerator.getRawName(model.name);
      final themeVarName = '${rawName.firstLowerCase}Theme';
      String $fieldContent = "late final ${model.name} $themeVarName;";
      if (model.desc != '') {
        $fieldContent = """
        /// ${model.desc} 
        ${$fieldContent}
        """;
      }
      fieldContent += $fieldContent;
      lightConstructionArgument += '${model.name}? $themeVarName,\n';
      lightConstructionContent +=
          "this.$themeVarName = ${model.name}.theme.merge($themeVarName);\n";
      darkConstructionArgument += '${model.name}? $themeVarName,\n';
      darkConstructionContent +=
          "this.$themeVarName = ${model.name}.darkTheme.merge($themeVarName);\n";
      copyWithArgument += '${model.name}? $themeVarName,\n';
      copyWithContent +=
          '$themeVarName: this.$themeVarName.merge($themeVarName),';
      mergeContent += '$themeVarName: other.$themeVarName,\n';
    }
    return """
class $globalThemeClassName extends $className {
  /// 亮色默认主题
  static final $globalThemeClassName theme = $globalThemeClassName();
  
  /// 暗色默认主题
  static final $globalThemeClassName darkTheme = $globalThemeClassName.dark();
  
  $fieldContent
  
  /// 亮色主题构造器
  $globalThemeClassName({
    $lightConstructionArgument
  }) {
    $lightConstructionContent
  }
  
  /// 暗色主题构造器，它是私有的，若要自定义主题请操作 [darkTheme] 实例
  $globalThemeClassName.dark({
    $darkConstructionArgument
  }) : super.dark() {
    $darkConstructionContent
  }
  
  /// 接收一组可选参数，返回新的对象
  $globalThemeClassName copyWith({
    $copyWithArgument
  }) {
    return $globalThemeClassName(
      $copyWithContent
    );
  }
}
    """;
  }
}

// 全局主题配置暂时不需要 merge 方法

// /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
// $globalThemeClassName merge([$globalThemeClassName? other]) {
//   if (other == null) return this;
//   return copyWith(
//       $mergeContent
//   );
// }
