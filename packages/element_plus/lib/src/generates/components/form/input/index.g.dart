// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/form/input/index.dart';

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
  /// 提供局部默认主题小部件
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

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElInputThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.inputTheme;

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
