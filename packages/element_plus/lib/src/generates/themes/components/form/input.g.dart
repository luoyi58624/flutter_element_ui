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

class ElInputTheme extends InheritedWidget {
  /// 设置局部默认数据，注意：如果你想尊重 "全局" 或 "祖先" 提供的默认样式，请使用 [merge] 方法构建
  const ElInputTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElInputThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElInputThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElInputTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElInputThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.inputTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElInputThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElInputTheme.of(context);
      return ElInputTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElInputTheme oldWidget) => true;
}
