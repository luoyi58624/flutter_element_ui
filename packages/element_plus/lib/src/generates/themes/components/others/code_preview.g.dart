// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/others/code_preview.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCodePreviewThemeDataExtension on ElCodePreviewThemeData {
  /// 接收一组可选参数，返回新的对象
  ElCodePreviewThemeData copyWith({
    String? fontFamily,
    Color? color,
    Color? bgColor,
    bool? enableSection,
  }) {
    return ElCodePreviewThemeData(
      fontFamily: fontFamily ?? this.fontFamily,
      color: color ?? this.color,
      bgColor: bgColor ?? this.bgColor,
      enableSection: enableSection ?? this.enableSection,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElCodePreviewThemeData merge([ElCodePreviewThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      fontFamily: other.fontFamily,
      color: other.color,
      bgColor: other.bgColor,
      enableSection: other.enableSection,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElCodePreviewTheme extends InheritedWidget {
  const ElCodePreviewTheme(
      {super.key, required super.child, required this.data});

  /// 主题数据
  final ElCodePreviewThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElCodePreviewThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElCodePreviewTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElCodePreviewThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.codePreviewTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElCodePreviewThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElCodePreviewTheme.of(context);
      return ElCodePreviewTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElCodePreviewTheme oldWidget) => true;
}
