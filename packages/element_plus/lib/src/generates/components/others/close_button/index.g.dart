// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/others/close_button/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCloseButtonThemeDataExtension on ElCloseButtonThemeData {
  /// 接收一组可选参数，返回新的对象
  ElCloseButtonThemeData copyWith({
    Color? iconHoverColor,
    Color? bgHoverColor,
    MouseCursor? cursor,
  }) {
    return ElCloseButtonThemeData(
      iconHoverColor: iconHoverColor ?? this.iconHoverColor,
      bgHoverColor: bgHoverColor ?? this.bgHoverColor,
      cursor: cursor ?? this.cursor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElCloseButtonThemeData merge([ElCloseButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      iconHoverColor: other.iconHoverColor,
      bgHoverColor: other.bgHoverColor,
      cursor: other.cursor,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElCloseButtonThemeData &&
          runtimeType == other.runtimeType &&
          iconHoverColor == other.iconHoverColor &&
          bgHoverColor == other.bgHoverColor &&
          cursor == other.cursor;

  /// 生成 hashCode 方法
  int get _hashCode =>
      iconHoverColor.hashCode ^ bgHoverColor.hashCode ^ cursor.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElCloseButtonTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElCloseButtonTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElCloseButtonThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElCloseButtonThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElCloseButtonTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElCloseButtonThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.closeButtonTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElCloseButtonTheme.of(context);
    return _ElCloseButtonTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElCloseButtonTheme extends InheritedWidget {
  const _ElCloseButtonTheme({
    required super.child,
    required this.data,
  });

  final ElCloseButtonThemeData data;

  @override
  bool updateShouldNotify(_ElCloseButtonTheme oldWidget) =>
      data != oldWidget.data;
}

class ElAnimatedCloseButtonTheme extends StatelessWidget {
  /// 提供带有动画的局部默认主题小部件
  const ElAnimatedCloseButtonTheme({
    super.key,
    required this.child,
    required this.data,
    this.duration,
    this.curve = Curves.linear,
    this.onEnd,
  });

  final Widget child;
  final ElCloseButtonThemeData data;
  final Duration? duration;
  final Curve curve;
  final VoidCallback? onEnd;

  @override
  Widget build(BuildContext context) {
    return _ElAnimatedCloseButtonTheme(
      duration: context.elDuration(duration),
      curve: curve,
      onEnd: onEnd,
      data: data,
      child: child,
    );
  }
}

class _ElAnimatedCloseButtonTheme extends ImplicitlyAnimatedWidget {
  const _ElAnimatedCloseButtonTheme({
    required this.data,
    required super.duration,
    super.curve,
    super.onEnd,
    required this.child,
  });

  final ElCloseButtonThemeData data;
  final Widget child;

  @override
  AnimatedWidgetBaseState<_ElAnimatedCloseButtonTheme> createState() =>
      _ElCloseButtonThemeDataState();
}

class _ElCloseButtonThemeDataState
    extends AnimatedWidgetBaseState<_ElAnimatedCloseButtonTheme> {
  ElCloseButtonThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
            _data,
            widget.data,
            (dynamic value) => ElCloseButtonThemeDataTween(
                begin: value as ElCloseButtonThemeData))!
        as ElCloseButtonThemeDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return ElCloseButtonTheme(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}

/// 生成的主题线性插值类
class ElCloseButtonThemeDataTween extends Tween<ElCloseButtonThemeData> {
  ElCloseButtonThemeDataTween({super.begin});

  @override
  ElCloseButtonThemeData lerp(double t) => _lerp(begin!, end!, t);

  static ElCloseButtonThemeData _lerp(
      ElCloseButtonThemeData a, ElCloseButtonThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElCloseButtonThemeData(
      iconHoverColor:
          Color.lerp(a.iconHoverColor, b.iconHoverColor, t) ?? a.iconHoverColor,
      bgHoverColor:
          Color.lerp(a.bgHoverColor, b.bgHoverColor, t) ?? a.bgHoverColor,
      cursor: t < 0.5 ? a.cursor : b.cursor,
    );
  }
}
