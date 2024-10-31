// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/layout/header.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElHeaderThemeDataExtension on ElHeaderThemeData {
  /// 接收一组可选参数，返回新的对象
  ElHeaderThemeData copyWith({
    Color? color,
    double? height,
  }) {
    return ElHeaderThemeData(
      color: color ?? this.color,
      height: height ?? this.height,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElHeaderThemeData merge([ElHeaderThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      height: other.height,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

extension ElHeaderThemeDataLerpExtension on ElHeaderThemeData {
  /// 默认主题动画线性插值
  ElHeaderThemeData lerp(ElHeaderThemeData a, ElHeaderThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElHeaderThemeData(
      color: Color.lerp(a.color, b.color, t) ?? a.color,
      height: lerpDouble(a.height, b.height, t) ?? a.height,
    );
  }
}

class ElHeaderTheme extends StatelessWidget {
  /// 提供局部默认主题小部件
  const ElHeaderTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElHeaderThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElHeaderThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElHeaderTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElHeaderThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.headerTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElHeaderTheme.of(context);
    return _ElHeaderTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElHeaderTheme extends InheritedWidget {
  const _ElHeaderTheme({
    required super.child,
    required this.data,
  });

  final ElHeaderThemeData data;

  @override
  bool updateShouldNotify(_ElHeaderTheme oldWidget) => true;
}
