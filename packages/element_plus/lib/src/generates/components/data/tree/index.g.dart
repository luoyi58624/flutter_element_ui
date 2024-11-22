// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/data/tree/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTreeThemeDataExtension on ElTreeThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTreeThemeData copyWith({
    Duration? duration,
    Curve? curve,
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
    return ElTreeThemeData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
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
  ElTreeThemeData merge([ElTreeThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      duration: other.duration,
      curve: other.curve,
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

class ElTreeTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElTreeTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElTreeThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTreeThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElTreeTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTreeThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.treeTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElTreeTheme.of(context);
    return _ElTreeTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElTreeTheme extends InheritedWidget {
  const _ElTreeTheme({
    required super.child,
    required this.data,
  });

  final ElTreeThemeData data;

  @override
  bool updateShouldNotify(_ElTreeTheme oldWidget) => true;
}
