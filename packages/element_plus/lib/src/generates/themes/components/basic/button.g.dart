// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/basic/button.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButtonThemeDataExtension on ElButtonThemeData {
  /// 接收一组可选参数，返回新的对象
  ElButtonThemeData copyWith({
    dynamic child,
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
    Border Function(ElButtonBorderState)? borderBuilder,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? iconSize,
    Widget? leftIcon,
    Widget? rightIcon,
    bool? circle,
    bool? disabled,
    bool? loading,
    Widget? loadingWidget,
    Widget Function(ElButtonLoadingState)? loadingBuilder,
  }) {
    return ElButtonThemeData(
      child: child ?? this.child,
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
      borderBuilder: borderBuilder ?? this.borderBuilder,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      iconSize: iconSize ?? this.iconSize,
      leftIcon: leftIcon ?? this.leftIcon,
      rightIcon: rightIcon ?? this.rightIcon,
      circle: circle ?? this.circle,
      disabled: disabled ?? this.disabled,
      loading: loading ?? this.loading,
      loadingWidget: loadingWidget ?? this.loadingWidget,
      loadingBuilder: loadingBuilder ?? this.loadingBuilder,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElButtonThemeData merge([ElButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      child: other.child,
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
      borderBuilder: other.borderBuilder,
      borderRadius: other.borderRadius,
      padding: other.padding,
      iconSize: other.iconSize,
      leftIcon: other.leftIcon,
      rightIcon: other.rightIcon,
      circle: other.circle,
      disabled: other.disabled,
      loading: other.loading,
      loadingWidget: other.loadingWidget,
      loadingBuilder: other.loadingBuilder,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElButtonTheme extends InheritedWidget {
  const ElButtonTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElButtonThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElButtonThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElButtonTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElButtonThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.buttonTheme;

  /// 接收自定义主题数据，将它与默认主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElButtonThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElButtonTheme.of(context);
      return ElButtonTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElButtonTheme oldWidget) => true;
}
