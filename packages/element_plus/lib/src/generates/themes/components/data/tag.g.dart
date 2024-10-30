// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/data/tag.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTagThemeDataExtension on ElTagThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTagThemeData copyWith({
    String? type,
    double? width,
    double? height,
    Color? bgColor,
    TextStyle? textStyle,
    bool? plain,
    bool? round,
    bool? closable,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElTagThemeData(
      type: type ?? this.type,
      width: width ?? this.width,
      height: height ?? this.height,
      bgColor: bgColor ?? this.bgColor,
      textStyle: this.textStyle?.merge(textStyle),
      plain: plain ?? this.plain,
      round: round ?? this.round,
      closable: closable ?? this.closable,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTagThemeData merge([ElTagThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      type: other.type,
      width: other.width,
      height: other.height,
      bgColor: other.bgColor,
      textStyle: other.textStyle,
      plain: other.plain,
      round: other.round,
      closable: other.closable,
      borderRadius: other.borderRadius,
      padding: other.padding,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElTagTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElTagTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElTagThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTagThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElTagTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTagThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elAnimatedTheme.tagTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElTagThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTagTheme.of(context);
      return ElTagTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElTagTheme oldWidget) => true;
}

extension ElTagThemeDataLerpExtension on ElTagThemeData {
  /// 主题动画线性插值
  ElTagThemeData lerp(ElTagThemeData a, ElTagThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElTagThemeData(
      type: t < 0.5 ? a.type : b.type,
      width: lerpDouble(a.width, b.width, t) ?? a.width,
      height: lerpDouble(a.height, b.height, t) ?? a.height,
      bgColor: Color.lerp(a.bgColor, b.bgColor, t) ?? a.bgColor,
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t) ?? a.textStyle,
      plain: t < 0.5 ? a.plain : b.plain,
      round: t < 0.5 ? a.round : b.round,
      closable: t < 0.5 ? a.closable : b.closable,
      borderRadius: BorderRadius.lerp(a.borderRadius, b.borderRadius, t) ??
          a.borderRadius,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
    );
  }
}
