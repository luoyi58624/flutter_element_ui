// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/button/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButtonThemeDataExtension on ElButtonThemeData {
  /// 接收一组可选参数，返回新的对象
  ElButtonThemeData copyWith({
    dynamic child,
    Duration? duration,
    double? width,
    double? height,
    Color? bgColor,
    Color? color,
    String? type,
    bool? text,
    bool? bg,
    bool? link,
    bool? plain,
    bool? round,
    bool? block,
    double? borderWidth,
    double? borderActiveWidth,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? iconSize,
    Widget? leftIcon,
    Widget? rightIcon,
    bool? circle,
    Widget? loadingWidget,
    Widget Function(ElButtonLoadingData)? loadingBuilder,
  }) {
    return ElButtonThemeData(
      child: child ?? this.child,
      duration: duration ?? this.duration,
      width: width ?? this.width,
      height: height ?? this.height,
      bgColor: bgColor ?? this.bgColor,
      color: color ?? this.color,
      type: type ?? this.type,
      text: text ?? this.text,
      bg: bg ?? this.bg,
      link: link ?? this.link,
      plain: plain ?? this.plain,
      round: round ?? this.round,
      block: block ?? this.block,
      borderWidth: borderWidth ?? this.borderWidth,
      borderActiveWidth: borderActiveWidth ?? this.borderActiveWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      iconSize: iconSize ?? this.iconSize,
      leftIcon: leftIcon ?? this.leftIcon,
      rightIcon: rightIcon ?? this.rightIcon,
      circle: circle ?? this.circle,
      loadingWidget: loadingWidget ?? this.loadingWidget,
      loadingBuilder: loadingBuilder ?? this.loadingBuilder,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElButtonThemeData merge([ElButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      child: other.child,
      duration: other.duration,
      width: other.width,
      height: other.height,
      bgColor: other.bgColor,
      color: other.color,
      type: other.type,
      text: other.text,
      bg: other.bg,
      link: other.link,
      plain: other.plain,
      round: other.round,
      block: other.block,
      borderWidth: other.borderWidth,
      borderActiveWidth: other.borderActiveWidth,
      borderRadius: other.borderRadius,
      padding: other.padding,
      iconSize: other.iconSize,
      leftIcon: other.leftIcon,
      rightIcon: other.rightIcon,
      circle: other.circle,
      loadingWidget: other.loadingWidget,
      loadingBuilder: other.loadingBuilder,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElButtonThemeData &&
          runtimeType == other.runtimeType &&
          child == other.child &&
          duration == other.duration &&
          width == other.width &&
          height == other.height &&
          bgColor == other.bgColor &&
          color == other.color &&
          type == other.type &&
          text == other.text &&
          bg == other.bg &&
          link == other.link &&
          plain == other.plain &&
          round == other.round &&
          block == other.block &&
          borderWidth == other.borderWidth &&
          borderActiveWidth == other.borderActiveWidth &&
          borderRadius == other.borderRadius &&
          padding == other.padding &&
          iconSize == other.iconSize &&
          leftIcon == other.leftIcon &&
          rightIcon == other.rightIcon &&
          circle == other.circle &&
          loadingWidget == other.loadingWidget &&
          loadingBuilder == other.loadingBuilder;

  /// 生成 hashCode 方法
  int get _hashCode =>
      child.hashCode ^
      duration.hashCode ^
      width.hashCode ^
      height.hashCode ^
      bgColor.hashCode ^
      color.hashCode ^
      type.hashCode ^
      text.hashCode ^
      bg.hashCode ^
      link.hashCode ^
      plain.hashCode ^
      round.hashCode ^
      block.hashCode ^
      borderWidth.hashCode ^
      borderActiveWidth.hashCode ^
      borderRadius.hashCode ^
      padding.hashCode ^
      iconSize.hashCode ^
      leftIcon.hashCode ^
      rightIcon.hashCode ^
      circle.hashCode ^
      loadingWidget.hashCode ^
      loadingBuilder.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElButtonTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElButtonTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElButtonThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElButtonThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElButtonTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElButtonThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.buttonTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElButtonTheme.of(context);
    return _ElButtonTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElButtonTheme extends InheritedWidget {
  const _ElButtonTheme({
    required super.child,
    required this.data,
  });

  final ElButtonThemeData data;

  @override
  bool updateShouldNotify(_ElButtonTheme oldWidget) => data != oldWidget.data;
}
