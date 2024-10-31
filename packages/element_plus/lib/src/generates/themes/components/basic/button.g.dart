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
    double? borderWidth,
    double? borderActiveWidth,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? iconSize,
    Widget? leftIcon,
    Widget? rightIcon,
    bool? circle,
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
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

extension ElButtonThemeDataLerpExtension on ElButtonThemeData {
  /// 默认主题动画线性插值
  ElButtonThemeData lerp(ElButtonThemeData a, ElButtonThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElButtonThemeData(
      child: t < 0.5 ? a.child : b.child,
      width: lerpDouble(a.width, b.width, t) ?? a.width,
      height: lerpDouble(a.height, b.height, t) ?? a.height,
      bgColor: Color.lerp(a.bgColor, b.bgColor, t) ?? a.bgColor,
      color: Color.lerp(a.color, b.color, t) ?? a.color,
      type: t < 0.5 ? a.type : b.type,
      text: t < 0.5 ? a.text : b.text,
      bg: t < 0.5 ? a.bg : b.bg,
      link: t < 0.5 ? a.link : b.link,
      plain: t < 0.5 ? a.plain : b.plain,
      round: t < 0.5 ? a.round : b.round,
      block: t < 0.5 ? a.block : b.block,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t) ?? a.borderWidth,
      borderActiveWidth:
          lerpDouble(a.borderActiveWidth, b.borderActiveWidth, t) ??
              a.borderActiveWidth,
      borderRadius: BorderRadius.lerp(a.borderRadius, b.borderRadius, t) ??
          a.borderRadius,
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
      iconSize: lerpDouble(a.iconSize, b.iconSize, t) ?? a.iconSize,
      leftIcon: t < 0.5 ? a.leftIcon : b.leftIcon,
      rightIcon: t < 0.5 ? a.rightIcon : b.rightIcon,
      circle: t < 0.5 ? a.circle : b.circle,
      loadingWidget: t < 0.5 ? a.loadingWidget : b.loadingWidget,
      loadingBuilder: t < 0.5 ? a.loadingBuilder : b.loadingBuilder,
    );
  }
}

class ElButtonTheme extends StatelessWidget {
  /// 提供局部默认主题小部件
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
  bool updateShouldNotify(_ElButtonTheme oldWidget) => true;
}

class ElAnimatedButtonTheme extends StatelessWidget {
  /// 提供带有动画的局部默认主题小部件
  const ElAnimatedButtonTheme({
    super.key,
    required this.child,
    required this.data,
    this.duration,
    this.curve,
    this.onEnd,
  });

  final Widget child;
  final ElButtonThemeData data;
  final Duration? duration;
  final Curve? curve;
  final VoidCallback? onEnd;

  @override
  Widget build(BuildContext context) {
    return _ElAnimatedButtonTheme(
      duration: context.elDuration(duration),
      curve: context.elCurve(curve),
      onEnd: onEnd,
      data: data,
      child: child,
    );
  }
}

class _ElAnimatedButtonTheme extends ImplicitlyAnimatedWidget {
  const _ElAnimatedButtonTheme({
    required this.data,
    required super.duration,
    super.curve,
    super.onEnd,
    required this.child,
  });

  final ElButtonThemeData data;
  final Widget child;

  @override
  AnimatedWidgetBaseState<_ElAnimatedButtonTheme> createState() =>
      _ElButtonThemeDataState();
}

class _ElButtonThemeDataState
    extends AnimatedWidgetBaseState<_ElAnimatedButtonTheme> {
  _ElButtonDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
            _data,
            widget.data,
            (dynamic value) =>
                _ElButtonDataTween(begin: value as ElButtonThemeData))!
        as _ElButtonDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return ElButtonTheme(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}

class _ElButtonDataTween extends Tween<ElButtonThemeData> {
  _ElButtonDataTween({super.begin});

  @override
  ElButtonThemeData lerp(double t) =>
      ElButtonThemeData.theme.lerp(begin!, end!, t);
}
