// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/form/input.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElInputThemeDataExtension on ElInputThemeData {
  /// 接收一组可选参数，返回新的对象
  ElInputThemeData copyWith({
    double? height,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return ElInputThemeData(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      textStyle: this.textStyle.merge(textStyle),
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElInputThemeData merge([ElInputThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      borderRadius: other.borderRadius,
      margin: other.margin,
      padding: other.padding,
      textStyle: other.textStyle,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElInputTheme extends StatelessWidget {
  const ElInputTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElInputThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElInputThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElInputTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据。
  ///
  /// 注意：默认值是动画主题，如果小部件存在隐式动画小部件，请使用 [maybeOf] + context.elTheme 引用主题。
  static ElInputThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elAnimatedTheme.inputTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElInputTheme.of(context);
    return _ElInputTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElInputTheme extends InheritedWidget {
  const _ElInputTheme({
    required super.child,
    required this.data,
  });

  final ElInputThemeData data;

  @override
  bool updateShouldNotify(_ElInputTheme oldWidget) => true;
}

extension ElInputThemeDataLerpExtension on ElInputThemeData {
  /// 主题动画线性插值
  ElInputThemeData lerp(ElInputThemeData a, ElInputThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElInputThemeData(
      height: lerpDouble(a.height, b.height, t) ?? a.height,
      borderRadius: BorderRadius.lerp(a.borderRadius, b.borderRadius, t) ??
          a.borderRadius,
      margin: EdgeInsetsGeometry.lerp(a.margin, b.margin, t) ?? a.margin,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t) ?? a.textStyle,
    );
  }
}
