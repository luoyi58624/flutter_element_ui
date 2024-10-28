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

class ElButtonTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElButtonTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElButtonThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElButtonThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElButtonTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElButtonThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.buttonTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
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

extension ElButtonThemeDataLerpExtension on ElButtonThemeData {
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

class ElAnimatedButtonTheme extends ImplicitlyAnimatedWidget {
  /// 提供动画默认数据小部件
  const ElAnimatedButtonTheme({
    super.key,
    required this.data,
    super.curve,
    super.duration = kThemeAnimationDuration,
    super.onEnd,
    required this.child,
  });

  final ElButtonThemeData data;
  final Widget child;

  @override
  AnimatedWidgetBaseState<ElAnimatedButtonTheme> createState() =>
      _ElButtonThemeDataState();
}

class _ElButtonThemeDataState
    extends AnimatedWidgetBaseState<ElAnimatedButtonTheme> {
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
    return ElButtonTheme.merge(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}

class _ElButtonDataTween extends Tween<ElButtonThemeData> {
  _ElButtonDataTween({super.begin});

  @override
  ElButtonThemeData lerp(double t) => _lerp(begin!, end!, t);

  static ElButtonThemeData _lerp(
      ElButtonThemeData a, ElButtonThemeData b, double t) {
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
