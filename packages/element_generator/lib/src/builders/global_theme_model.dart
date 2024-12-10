import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:element_generator/src/builders/theme_model.dart';
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
    if (className.startsWith('_') == false) {
      throw '生成 GlobalTheme 的类名必须以 _ 开头';
    }
    if (className.endsWith('ThemeData') == false) {
      throw '生成 GlobalTheme 的类名必须以 ThemeData 结尾';
    }
    final globalThemeClassName = className.substring(1);
    final classFields = MirrorUtils.filterFields(classInfo);

    String fieldContent = "";
    String lightInstanceArgument = "";
    String darkInstanceArgument = "";
    String lightConstructionArgument = "";
    String darkConstructionArgument = "";
    String copyWithArgument = '';
    String copyWithContent = '';
    String mergeContent = '';

    for (final fieldInfo in classFields) {
      final fieldName = fieldInfo.name;
      lightConstructionArgument += 'super.$fieldName,';
      copyWithArgument += '${fieldInfo.type.toString()}? $fieldName,\n';
      copyWithContent += '$fieldName: $fieldName ?? super.$fieldName,\n';
      mergeContent += '$fieldName: other.$fieldName,\n';
    }

    print(ElThemeModelGenerator.themeModelList.map((e) => e.name).toList());
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
      lightInstanceArgument += '$themeVarName: ${model.name}.theme,\n';
      darkInstanceArgument += '$themeVarName: ${model.name}.darkTheme,\n';
      lightConstructionArgument += 'required this.$themeVarName,\n';
      darkConstructionArgument += 'required this.$themeVarName,\n';
      copyWithArgument += '${model.name}? $themeVarName,\n';
      copyWithContent +=
          '$themeVarName: this.$themeVarName.merge($themeVarName),';
      mergeContent += '$themeVarName: other.$themeVarName,\n';
    }
    return """
class $globalThemeClassName extends $className {
  /// 亮色默认主题
  static const $globalThemeClassName theme = $globalThemeClassName._(
    $lightInstanceArgument
  );
  
  /// 暗色默认主题
  static const $globalThemeClassName darkTheme = $globalThemeClassName._dark(
    $darkInstanceArgument
  );
  
  $fieldContent
  
  /// 亮色主题构造器，构建器是私有的，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const $globalThemeClassName._({
    $lightConstructionArgument
  });
  
  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const $globalThemeClassName._dark({
    $darkConstructionArgument
  }) : super.dark();
  
  /// 接收一组可选参数，返回新的对象
  $globalThemeClassName copyWith({
    $copyWithArgument
  }) {
    return $globalThemeClassName._(
      $copyWithContent
    );
  }
  
  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  $globalThemeClassName merge([$globalThemeClassName? other]) {
    if (other == null) return this;
    return copyWith(
      $mergeContent
    );
  }
}
""";
  }
}
