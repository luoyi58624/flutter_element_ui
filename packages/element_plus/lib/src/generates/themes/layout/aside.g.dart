// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/layout/aside.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElAsideThemeDataExtension on ElAsideThemeData {
  /// 接收一组可选参数，返回新的对象
  ElAsideThemeData copyWith({
    Color? color,
    double? width,
  }) {
    return ElAsideThemeData(
      color: color ?? this.color,
      width: width ?? this.width,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElAsideThemeData merge([ElAsideThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      width: other.width,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

extension ElAsideThemeDataLerpExtension on ElAsideThemeData {
  /// 默认主题动画线性插值
  ElAsideThemeData lerp(ElAsideThemeData a, ElAsideThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElAsideThemeData(
      color: Color.lerp(a.color, b.color, t) ?? a.color,
      width: lerpDouble(a.width, b.width, t) ?? a.width,
    );
  }
}

class ElAsideTheme extends StatelessWidget {
  /// 提供局部默认主题小部件
  const ElAsideTheme({
    super.key,
    required this.child,
    required this.data,
  });

  final Widget child;
  final ElAsideThemeData data;

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElAsideThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElAsideTheme>()?.data;

  /// 通过上下文访问默认的主题数据，如果为 null，则返回默认的全局主题数据
  static ElAsideThemeData of(BuildContext context) =>
      maybeOf(context) ?? context.elTheme.asideTheme;

  @override
  Widget build(BuildContext context) {
    final parent = ElAsideTheme.of(context);
    return _ElAsideTheme(
      data: parent.merge(data),
      child: child,
    );
  }
}

class _ElAsideTheme extends InheritedWidget {
  const _ElAsideTheme({
    required super.child,
    required this.data,
  });

  final ElAsideThemeData data;

  @override
  bool updateShouldNotify(_ElAsideTheme oldWidget) => true;
}
