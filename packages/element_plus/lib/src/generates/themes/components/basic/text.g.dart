// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/basic/text.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTextThemeDataExtension on ElTextThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTextThemeData copyWith({
    Color? testColor,
    dynamic data,
    Duration? duration,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    return ElTextThemeData(
      testColor: testColor ?? this.testColor,
      data: data ?? this.data,
      duration: duration ?? this.duration,
      style: this.style.merge(style),
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      textScaler: textScaler ?? this.textScaler,
      maxLines: maxLines ?? this.maxLines,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTextThemeData merge([ElTextThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      testColor: other.testColor,
      data: other.data,
      duration: other.duration,
      style: other.style,
      strutStyle: other.strutStyle,
      textAlign: other.textAlign,
      textDirection: other.textDirection,
      locale: other.locale,
      softWrap: other.softWrap,
      overflow: other.overflow,
      textScaler: other.textScaler,
      maxLines: other.maxLines,
      textWidthBasis: other.textWidthBasis,
      textHeightBehavior: other.textHeightBehavior,
      selectionColor: other.selectionColor,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElTextTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElTextTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElTextThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTextThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElTextTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTextThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.textTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElTextThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTextTheme.of(context);
      return ElTextTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElTextTheme oldWidget) => true;
}
