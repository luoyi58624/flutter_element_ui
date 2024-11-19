import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

import '../utils.dart';

/// 数据类命名前缀，用于解析出目标字段名，字段名通常不需要特定的前缀，例如：ElButtonThemeData -> buttonTheme
const String _prefix = 'El';

/// 数据类命名后缀
const String _suffix = 'Data';

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
    if (rawName.endsWith('Theme')) {
      rawName = rawName.substring(0, rawName.lastIndexOf('Theme'));
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
        ${generateAnimatedWidget(annotation)}
    """;
    return result;
  }

  String generateThemeWidget(ConstantReader annotation) {
    bool generateThemeWidget = annotation.read('generateThemeWidget').boolValue;
    if (!generateThemeWidget) return '';

    assert(
        _className.startsWith(_prefix), '生成 ThemeWidget 的模型类必须以 $_prefix 开始');
    assert(_className.endsWith(_suffix), '生成 ThemeWidget 的模型类必须以 $_suffix 结尾');
    String themeClassName =
        _className.substring(0, _className.lastIndexOf(_suffix));
    String globalThemeFieldName =
        themeClassName.substring(_prefix.length).firstLowerCase;
    // String fieldName = '$_prefix$rawName$_suffix';

    late String ofContent;

    if (_ignoreGlobalTheme) {
      ofContent = """
static $_className of(BuildContext context) {
  final _$themeClassName? result = context.dependOnInheritedWidgetOfExactType<_$themeClassName>();
  assert(result != null, 'No _$themeClassName found in context');
    return result!.data;
}""";
    } else {
      ofContent = """
/// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
static $_className of(BuildContext context) =>
  maybeOf(context) ?? context.elTheme.$globalThemeFieldName;""";
    }

    return """
class $themeClassName extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const $themeClassName({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final $_className data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static $_className? maybeOf(BuildContext context) =>
     context.dependOnInheritedWidgetOfExactType<_$themeClassName>()?.data;
     
  $ofContent

  @override
  Widget build(BuildContext context) {
    final parent = $themeClassName.of(context);
    return _$themeClassName(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _$themeClassName extends InheritedWidget {
  const _$themeClassName({
    required super.child,
    required this.data,
  });

  final $_className data;
  
  @override
  bool updateShouldNotify(_$themeClassName oldWidget) => true;
}    
    """;
  }

  String generateAnimatedWidget(ConstantReader annotation) {
    bool generateThemeWidget = annotation.read('generateThemeWidget').boolValue;
    if (!generateThemeWidget) return '';
    bool generateAnimatedThemeWidget =
        annotation.read('generateAnimatedThemeWidget').boolValue;
    if (!generateAnimatedThemeWidget) return '';

    String themeClassName =
        _className.substring(0, _className.lastIndexOf(_suffix));
    String animatedThemeClassName =
        '${_prefix}Animated${themeClassName.substring(_prefix.length)}';
    String tweenClassName = '_$_prefix${getRawName(_className)}DataTween';

    String lerpContent = '';
    for (int i = 0; i < _classFields.length; i++) {
      final fieldInfo = _classFields[i].declaration;
      lerpContent += MirrorUtils.generateFieldLerp(fieldInfo);
    }

    return """
class $animatedThemeClassName extends StatelessWidget {
  /// 提供带有动画的局部默认主题小部件
  const $animatedThemeClassName({
    super.key,
    required this.child,
    required this.data,
    this.duration,
    this.curve = Curves.linear,
    this.onEnd,
  });

  final Widget child;
  final $_className data;
  final Duration? duration;
  final Curve curve;
  final VoidCallback? onEnd;

  @override
  Widget build(BuildContext context) {
    return _$animatedThemeClassName(
      duration: context.elDuration(duration),
      curve: curve,
      onEnd: onEnd,
      data: data,
      child: child,
    );
  }
}  
    
class _$animatedThemeClassName extends ImplicitlyAnimatedWidget {
  const _$animatedThemeClassName({
    required this.data,
    required super.duration,
    super.curve,
    super.onEnd,
    required this.child,
  });

  final $_className data;
  final Widget child;

  @override
  AnimatedWidgetBaseState<_$animatedThemeClassName> createState() =>
      _${_className}State();
}

class _${_className}State extends AnimatedWidgetBaseState<_$animatedThemeClassName> {
  $tweenClassName? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(_data, widget.data,
            (dynamic value) => $tweenClassName(begin: value as $_className))!
        as $tweenClassName;
  }

  @override
  Widget build(BuildContext context) {
    return $themeClassName(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}

class $tweenClassName extends Tween<$_className> {
  $tweenClassName({super.begin});

  @override
  $_className lerp(double t) => _lerp(begin!, end!, t);
  
  static $_className _lerp($_className a, $_className b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return $_className(
        $lerpContent
    );
  }
}
    """;
  }
}
