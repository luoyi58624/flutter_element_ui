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
    if (className.startsWith('_') == false) {
      throw '生成 GlobalTheme 的类名必须以 _ 开头';
    }
    if (className.endsWith('ThemeData') == false) {
      throw '生成 GlobalTheme 的类名必须以 ThemeData 结尾';
    }
    final globalThemeClassName = className.substring(1);
    final globalThemeWidgetClassName =
        globalThemeClassName.replaceAll('ThemeData', 'Theme');
    final globalAnimateThemeWidgetClassName =
        globalThemeClassName.replaceAll('ThemeData', 'AnimatedTheme');
    final globalAnimateTweenClassName =
        globalThemeClassName.replaceAll('ThemeData', 'ThemeDataTween');

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
  
  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  $globalThemeClassName merge([$globalThemeClassName? other]) {
    if (other == null) return this;
    return copyWith(
      $mergeContent
    );
  }
}

class $globalThemeWidgetClassName extends InheritedWidget {
  /// 为后代提供默认数据小部件
  const $globalThemeWidgetClassName({super.key, required super.child, required this.data});

  /// 主题数据
  final $globalThemeClassName data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static $globalThemeClassName? maybeOf(BuildContext context) =>
     context.dependOnInheritedWidgetOfExactType<$globalThemeWidgetClassName>()?.data;
  
  static $globalThemeClassName of(BuildContext context) {
    final $globalThemeWidgetClassName? result = context.dependOnInheritedWidgetOfExactType<$globalThemeWidgetClassName>();
    assert(result != null, 'No $globalThemeWidgetClassName found in context');
    return result!.data;
  }

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    $globalThemeClassName? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = $globalThemeWidgetClassName.of(context);
      return $globalThemeWidgetClassName(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify($globalThemeWidgetClassName oldWidget) => true;
}



class $globalAnimateThemeWidgetClassName extends ImplicitlyAnimatedWidget {
  /// 提供动画默认数据小部件
  const $globalAnimateThemeWidgetClassName({
    super.key,
    required this.data,
    super.curve,
    super.duration = kThemeAnimationDuration,
    super.onEnd,
    required this.child,
  });

  final $globalThemeClassName data;
  final Widget child;

  @override
  AnimatedWidgetBaseState<$globalAnimateThemeWidgetClassName> createState() =>
      _${globalThemeClassName}State();
}

class _${globalThemeClassName}State extends AnimatedWidgetBaseState<$globalAnimateThemeWidgetClassName> {
  $globalAnimateTweenClassName? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(_data, widget.data,
            (dynamic value) => $globalAnimateTweenClassName(begin: value as $globalThemeClassName))!
        as $globalAnimateTweenClassName;
  }

  @override
  Widget build(BuildContext context) {
    return $globalThemeWidgetClassName(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}
    """;
  }
}

// class $globalAnimateTweenClassName extends Tween<$globalThemeClassName> {
//   $globalAnimateTweenClassName({super.begin, super.end});
//
//   @override
//   $globalThemeClassName lerp(double t) => _lerp(begin!, end!, t);
//
//   static $globalThemeClassName _lerp($globalThemeClassName a, $globalThemeClassName b, double t) {
//     if (identical(a, b)) {
//       return a;
//     }
//
//     return $globalThemeClassName(
//       primary: Color.lerp(a.primary, b.primary, t)!,
//       success: Color.lerp(a.success, b.success, t)!,
//     );
//   }
// }