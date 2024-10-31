// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/data/tag.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTagThemeDataExtension on ElTagThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTagThemeData copyWith({
    String? type,
    Widget? icon,
    double? width,
    double? height,
    Color? bgColor,
    Color? textColor,
    double? textSize,
    Color? iconColor,
    double? iconSize,
    bool? plain,
    bool? round,
    bool? closable,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElTagThemeData(
      type: type ?? this.type,
      icon: icon ?? this.icon,
      width: width ?? this.width,
      height: height ?? this.height,
      bgColor: bgColor ?? this.bgColor,
      textColor: textColor ?? this.textColor,
      textSize: textSize ?? this.textSize,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
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
      icon: other.icon,
      width: other.width,
      height: other.height,
      bgColor: other.bgColor,
      textColor: other.textColor,
      textSize: other.textSize,
      iconColor: other.iconColor,
      iconSize: other.iconSize,
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

class ElTagTheme extends StatelessWidget {
  const ElTagTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElTagThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTagThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElTagTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据。
  ///
  /// 注意：默认值是动画主题，如果小部件存在隐式动画小部件，请使用 [maybeOf] + context.elTheme 引用主题。
  static ElTagThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elAnimatedTheme.tagTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElTagTheme.of(context);
    return _ElTagTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElTagTheme extends InheritedWidget {
  const _ElTagTheme({
    required super.child,
    required this.data,
  });

  final ElTagThemeData data;

  @override
  bool updateShouldNotify(_ElTagTheme oldWidget) => true;
}

extension ElTagThemeDataLerpExtension on ElTagThemeData {
  /// 主题动画线性插值
  ElTagThemeData lerp(ElTagThemeData a, ElTagThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElTagThemeData(
      type: t < 0.5 ? a.type : b.type,
      icon: t < 0.5 ? a.icon : b.icon,
      width: lerpDouble(a.width, b.width, t) ?? a.width,
      height: lerpDouble(a.height, b.height, t) ?? a.height,
      bgColor: Color.lerp(a.bgColor, b.bgColor, t) ?? a.bgColor,
      textColor: Color.lerp(a.textColor, b.textColor, t) ?? a.textColor,
      textSize: lerpDouble(a.textSize, b.textSize, t) ?? a.textSize,
      iconColor: Color.lerp(a.iconColor, b.iconColor, t) ?? a.iconColor,
      iconSize: lerpDouble(a.iconSize, b.iconSize, t) ?? a.iconSize,
      plain: t < 0.5 ? a.plain : b.plain,
      round: t < 0.5 ? a.round : b.round,
      closable: t < 0.5 ? a.closable : b.closable,
      borderRadius: BorderRadius.lerp(a.borderRadius, b.borderRadius, t) ??
          a.borderRadius,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
    );
  }
}
