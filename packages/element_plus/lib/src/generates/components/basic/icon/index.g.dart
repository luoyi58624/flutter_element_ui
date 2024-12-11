// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/icon/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElIconThemeDataExtension on ElIconThemeData {
  /// 接收一组可选参数，返回新的对象
  ElIconThemeData copyWith({
    dynamic icon,
    double? size,
    Color? color,
  }) {
    return ElIconThemeData(
      icon: icon ?? this.icon,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElIconThemeData merge([ElIconThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      icon: other.icon,
      size: other.size,
      color: other.color,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElIconThemeData &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          size == other.size &&
          color == other.color;

  /// 生成 hashCode 方法
  int get _hashCode => icon.hashCode ^ size.hashCode ^ color.hashCode;
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElIconTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElIconTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElIconThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElIconThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElIconTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElIconThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.iconTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElIconTheme.of(context);
    return _ElIconTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElIconTheme extends InheritedWidget {
  const _ElIconTheme({
    required super.child,
    required this.data,
  });

  final ElIconThemeData data;

  @override
  bool updateShouldNotify(_ElIconTheme oldWidget) => data != oldWidget.data;
}

class ElAnimatedIconTheme extends StatelessWidget {
  /// 提供带有动画的局部默认主题小部件
  const ElAnimatedIconTheme({
    super.key,
    required this.child,
    required this.data,
    this.duration,
    this.curve = Curves.linear,
    this.onEnd,
  });

  final Widget child;
  final ElIconThemeData data;
  final Duration? duration;
  final Curve curve;
  final VoidCallback? onEnd;

  @override
  Widget build(BuildContext context) {
    return _ElAnimatedIconTheme(
      duration: context.elDuration(duration),
      curve: curve,
      onEnd: onEnd,
      data: data,
      child: child,
    );
  }
}

class _ElAnimatedIconTheme extends ImplicitlyAnimatedWidget {
  const _ElAnimatedIconTheme({
    required this.data,
    required super.duration,
    super.curve,
    super.onEnd,
    required this.child,
  });

  final ElIconThemeData data;
  final Widget child;

  @override
  AnimatedWidgetBaseState<_ElAnimatedIconTheme> createState() =>
      _ElIconThemeDataState();
}

class _ElIconThemeDataState
    extends AnimatedWidgetBaseState<_ElAnimatedIconTheme> {
  ElIconThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
            _data,
            widget.data,
            (dynamic value) =>
                ElIconThemeDataTween(begin: value as ElIconThemeData))!
        as ElIconThemeDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return ElIconTheme(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}

/// 生成的主题线性插值类
class ElIconThemeDataTween extends Tween<ElIconThemeData> {
  ElIconThemeDataTween({super.begin});

  @override
  ElIconThemeData lerp(double t) => _lerp(begin!, end!, t);

  static ElIconThemeData _lerp(ElIconThemeData a, ElIconThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElIconThemeData(
      icon: t < 0.5 ? a.icon : b.icon,
      size: lerpDouble(a.size, b.size, t) ?? a.size,
      color: Color.lerp(a.color, b.color, t) ?? a.color,
    );
  }
}
