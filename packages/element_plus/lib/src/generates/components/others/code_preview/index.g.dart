// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/others/code_preview/index.dart';

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

class ElCodePreviewTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElCodePreviewTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElCodePreviewThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElCodePreviewThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElCodePreviewTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElCodePreviewThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.codePreviewTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElCodePreviewTheme.of(context);
    return _ElCodePreviewTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElCodePreviewTheme extends InheritedWidget {
  const _ElCodePreviewTheme({
    required super.child,
    required this.data,
  });

  final ElCodePreviewThemeData data;

  @override
  bool updateShouldNotify(_ElCodePreviewTheme oldWidget) => true;
}
