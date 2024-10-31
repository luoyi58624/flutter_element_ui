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

extension ElCodePreviewThemeDataLerpExtension on ElCodePreviewThemeData {
  /// 默认主题动画线性插值
  ElCodePreviewThemeData lerp(
      ElCodePreviewThemeData a, ElCodePreviewThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElCodePreviewThemeData(
      fontFamily: t < 0.5 ? a.fontFamily : b.fontFamily,
      color: Color.lerp(a.color, b.color, t) ?? a.color,
      bgColor: Color.lerp(a.bgColor, b.bgColor, t) ?? a.bgColor,
      enableSection: t < 0.5 ? a.enableSection : b.enableSection,
    );
  }
}

class ElCodePreviewTheme extends StatelessWidget {
  /// 提供局部默认主题小部件
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
