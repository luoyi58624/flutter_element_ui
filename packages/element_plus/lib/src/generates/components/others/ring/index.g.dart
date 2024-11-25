// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/others/ring/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElRingThemeDataExtension on ElRingThemeData {
  /// 接收一组可选参数，返回新的对象
  ElRingThemeData copyWith({
    Duration? duration,
    Curve? curve,
    bool? show,
    double? offset,
    double? width,
    BorderRadius? radius,
    Color? color,
  }) {
    return ElRingThemeData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      show: show ?? this.show,
      offset: offset ?? this.offset,
      width: width ?? this.width,
      radius: radius ?? this.radius,
      color: color ?? this.color,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElRingThemeData merge([ElRingThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      duration: other.duration,
      curve: other.curve,
      show: other.show,
      offset: other.offset,
      width: other.width,
      radius: other.radius,
      color: other.color,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

class ElRingTheme extends StatelessWidget {
  /// 提供局部默认主题小部件，局部默认主题必须强制继承祖先提供的样式
  const ElRingTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElRingThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElRingThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElRingTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElRingThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.ringTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElRingTheme.of(context);
    return _ElRingTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElRingTheme extends InheritedWidget {
  const _ElRingTheme({
    required super.child,
    required this.data,
  });

  final ElRingThemeData data;

  @override
  bool updateShouldNotify(_ElRingTheme oldWidget) => true;
}
