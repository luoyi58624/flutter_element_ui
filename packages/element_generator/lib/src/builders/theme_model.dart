import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../utils.dart';

/// Element 组件命名前缀
const String _prefix = 'El';

/// Element 组件主题数据后缀
const String _suffix = 'ThemeData';

/// 当前实体类的信息
late ClassElement _classInfo;

/// 当前实体类的类名
late String _className;

/// 当前实体类的字段列表
late List<FieldElement> _classFields;

/// 是否忽略全局主题配置
late bool _ignoreGlobalTheme;

class ThemeModelRecord {
  final String name;
  final String desc;

  ThemeModelRecord({
    required this.name,
    required this.desc,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModelRecord &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

@immutable
class ElThemeModelGenerator extends GeneratorForAnnotation<ElThemeModel> {
  /// 记录所有添加 ElThemeModel 注解的类名
  static final Set<ThemeModelRecord> themeModelList = {};

  /// 过滤前缀和后缀，获取单纯的组件名字，例如：
  /// * ElButtonThemeData -> Button
  /// * ElLinkThemeData -> Link
  static String getRawName(String className) {
    String rawName = className;
    if (rawName.startsWith(_prefix)) {
      rawName = rawName.substring(_prefix.length);
    }
    if (rawName.endsWith(_suffix)) {
      rawName = rawName.substring(0, rawName.lastIndexOf(_suffix));
    }
    return rawName;
  }

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    _classInfo = element as ClassElement;
    _className = _classInfo.name;
    _classFields = MirrorUtils.filterFields(_classInfo);

    _ignoreGlobalTheme = annotation.read('ignoreGlobalTheme').boolValue;

    if (_ignoreGlobalTheme != true) {
      String desc = annotation.read('desc').stringValue;
      themeModelList.add(ThemeModelRecord(name: _className, desc: desc));
    }

    String result = """
        ${generateThemeWidget(annotation)}
        ${generateLerp(annotation)}
    """;
    return result;
  }

  String generateThemeWidget(ConstantReader annotation) {
    bool generateInheritedWidget =
        annotation.read('generateInheritedWidget').boolValue;
    if (!generateInheritedWidget) return '';

    final rawName = getRawName(_className);
    String themeClassName = '$_prefix${rawName}Theme';
    // String fieldName = '$_prefix$rawName$_suffix';

    late String ofContent;

    if (_ignoreGlobalTheme) {
      ofContent = """
static $_className of(BuildContext context) {
  final $themeClassName? result = context.dependOnInheritedWidgetOfExactType<$themeClassName>();
  assert(result != null, 'No $themeClassName found in context');
    return result!.data;
}""";
    } else {
      ofContent = """
/// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
static $_className of(BuildContext context) =>
  maybeOf(context) ?? context.elTheme.${rawName.firstLowerCase}Theme;""";
    }

    return """
class $themeClassName extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const $themeClassName({super.key, required super.child, required this.data});

  /// 主题数据
  final $_className data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static $_className? maybeOf(BuildContext context) =>
     context.dependOnInheritedWidgetOfExactType<$themeClassName>()?.data;
  
  $ofContent

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    $_className? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = $themeClassName.of(context);
      return $themeClassName(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify($themeClassName oldWidget) => true;
}
    """;
  }

  String generateLerp(ConstantReader annotation) {
    String content = '';
    for (int i = 0; i < _classFields.length; i++) {
      final fieldInfo = _classFields[i].declaration;
      content += MirrorUtils.generateFieldLerp(fieldInfo);
    }

    return """
extension ${_className}LerpExtension on $_className {
  $_className lerp($_className a, $_className b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return $_className(
      $content
    );
  }
}

    """;
  }
}
