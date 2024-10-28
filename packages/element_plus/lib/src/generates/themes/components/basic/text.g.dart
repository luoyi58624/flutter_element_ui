// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/basic/text.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTextThemeDataExtension on ElTextThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTextThemeData copyWith({
    dynamic data,
    Duration? duration,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    return ElTextThemeData(
      data: data ?? this.data,
      duration: duration ?? this.duration,
      style: this.style.merge(style),
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? this.overflow,
      textScaler: textScaler ?? this.textScaler,
      maxLines: maxLines ?? this.maxLines,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTextThemeData merge([ElTextThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      data: other.data,
      duration: other.duration,
      style: other.style,
      strutStyle: other.strutStyle,
      textAlign: other.textAlign,
      textDirection: other.textDirection,
      locale: other.locale,
      softWrap: other.softWrap,
      overflow: other.overflow,
      textScaler: other.textScaler,
      maxLines: other.maxLines,
      textWidthBasis: other.textWidthBasis,
      textHeightBehavior: other.textHeightBehavior,
      selectionColor: other.selectionColor,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElTextTheme extends InheritedWidget {
  /// 设置局部默认数据，提示：请尽量使用 [merge] 方法构建默认主题数据
  const ElTextTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElTextThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElTextThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElTextTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElTextThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.textTheme;

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElTextThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTextTheme.of(context);
      return ElTextTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

  @override
  bool updateShouldNotify(ElTextTheme oldWidget) => true;
}

extension ElTextThemeDataLerpExtension on ElTextThemeData {
  ElTextThemeData lerp(ElTextThemeData a, ElTextThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElTextThemeData(
      data: t < 0.5 ? a.data : b.data,
      duration: t < 0.5 ? a.duration : b.duration,
      style: TextStyle.lerp(a.style, b.style, t) ?? a.style,
      strutStyle: t < 0.5 ? a.strutStyle : b.strutStyle,
      textAlign: t < 0.5 ? a.textAlign : b.textAlign,
      textDirection: t < 0.5 ? a.textDirection : b.textDirection,
      locale: t < 0.5 ? a.locale : b.locale,
      softWrap: t < 0.5 ? a.softWrap : b.softWrap,
      overflow: t < 0.5 ? a.overflow : b.overflow,
      textScaler: t < 0.5 ? a.textScaler : b.textScaler,
      maxLines: t < 0.5 ? a.maxLines : b.maxLines,
      textWidthBasis: t < 0.5 ? a.textWidthBasis : b.textWidthBasis,
      textHeightBehavior: t < 0.5 ? a.textHeightBehavior : b.textHeightBehavior,
      selectionColor:
          Color.lerp(a.selectionColor, b.selectionColor, t) ?? a.selectionColor,
    );
  }
}

class ElAnimatedTextTheme extends ImplicitlyAnimatedWidget {
  /// 提供动画默认数据小部件
  const ElAnimatedTextTheme({
    super.key,
    required this.data,
    super.curve,
    super.duration = kThemeAnimationDuration,
    super.onEnd,
    required this.child,
  });

  final ElTextThemeData data;
  final Widget child;

  @override
  AnimatedWidgetBaseState<ElAnimatedTextTheme> createState() =>
      _ElTextThemeDataState();
}

class _ElTextThemeDataState
    extends AnimatedWidgetBaseState<ElAnimatedTextTheme> {
  _ElTextDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
            _data,
            widget.data,
            (dynamic value) =>
                _ElTextDataTween(begin: value as ElTextThemeData))!
        as _ElTextDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return ElTextTheme.merge(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}

class _ElTextDataTween extends Tween<ElTextThemeData> {
  _ElTextDataTween({super.begin});

  @override
  ElTextThemeData lerp(double t) => _lerp(begin!, end!, t);

  static ElTextThemeData _lerp(ElTextThemeData a, ElTextThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElTextThemeData(
      data: t < 0.5 ? a.data : b.data,
      duration: t < 0.5 ? a.duration : b.duration,
      style: TextStyle.lerp(a.style, b.style, t) ?? a.style,
      strutStyle: t < 0.5 ? a.strutStyle : b.strutStyle,
      textAlign: t < 0.5 ? a.textAlign : b.textAlign,
      textDirection: t < 0.5 ? a.textDirection : b.textDirection,
      locale: t < 0.5 ? a.locale : b.locale,
      softWrap: t < 0.5 ? a.softWrap : b.softWrap,
      overflow: t < 0.5 ? a.overflow : b.overflow,
      textScaler: t < 0.5 ? a.textScaler : b.textScaler,
      maxLines: t < 0.5 ? a.maxLines : b.maxLines,
      textWidthBasis: t < 0.5 ? a.textWidthBasis : b.textWidthBasis,
      textHeightBehavior: t < 0.5 ? a.textHeightBehavior : b.textHeightBehavior,
      selectionColor:
          Color.lerp(a.selectionColor, b.selectionColor, t) ?? a.selectionColor,
    );
  }
}
